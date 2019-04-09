#!/bin/bash

#$ -N tblastx_coral

#$ -j y

#$ -t 1-176

# To submitt the job array : qsub blastn_coral.sh 
# Before running this script, format the database:
# makeblastdb -in coral_cds_combined.fasta -input_type fasta -dbtype nucl -out coralDB
# make the output folder : mkdir /home1/mlittle/BLAST_holobiont/BLASTn_coral_80
# make the list of IDS : ls /home1/mlittle/BLAST_holobiont/BLASTn_coral_80 | grep 'fasta' | cut -d '.' -f1 > /home1/mlittle/BLAST_holobiont/BLASTn_coral_80/IDS.txt

DS_FOLDER=/home1/mlittle/metagenomes_and_viromes_for_FRAP
DB_PATH=/home1/mlittle/DB_BLASTn/
DB_NAME=coralDB
OUT_FOLDER=/home1/mlittle/BLAST_holobiont/BLASTn_coral_80

#PATH=$PATH:~/bin/smalt
#PATH=$PATH:/usr/local/smalt/bin/
PATH=$PATH:/usr/local/blast+/bin/blastn

#if [ $SGE_TASK_ID == 1 ]; then
#	mkdir $OUT_FOLDER
#	ls $DS_FOLDER | grep 'fasta' | cut -d '.' -f1 > ${OUT_FOLDER}/IDS.txt
#	fi

#until [ -e ${OUT_FOLDER}/IDS.txt ]; do
#	sleep 5
#	done  

IDSFILE=${OUT_FOLDER}/IDS.txt
ID=$(cat $IDSFILE | head -n $SGE_TASK_ID | tail -n 1)
/usr/local/blast+/bin/tblastx -query ${DS_FOLDER}/${ID}.fasta -db ${DB_PATH}${DB_NAME} -out ${OUT_FOLDER}/vs_${DB_NAME}_e01_${ID}.tblastx -evalue 0.1 -max_target_seqs 1 -outfmt '6 qseqid sseqid pident length mismatchgapopen qstart qend sstart send evalue bitscore'

#perl /home1/mlittle/bin/besthitblast.pl ${OUT_FOLDER}/vs_${DB_NAME}_80id_${ID}.blastn > ${OUT_FOLDER}/besthit_vs_${DB_NAME}_80id_${ID}.blastn
	
#to count, go to the folder with the blast besthit results :
#ls | grep 'besthit*' | xargs -I{} sh -c 'wc -l {}' | sed 's/ /\t/'  > coral_hits.txt

#example for tblastx, there is no -perc_identity 80 -qcov_hsp_perc 100, **we need to figure out the parsinbg parameters**

tblastx -query /home3/acobian/tblastx_test/ds/test1.fasta -db /home3/acobian/tblastx_test/db/viral -out test1_vs_viral.tblastx -evalue 0.1 -max_target_seqs 1 -outfmt '6 qseqid sseqid pident length mismatchgapopen qstart qend sstart send evalue bitscore'
 
