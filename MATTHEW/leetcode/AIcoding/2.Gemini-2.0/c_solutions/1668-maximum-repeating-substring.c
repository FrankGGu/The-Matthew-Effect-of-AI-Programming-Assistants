#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxRepeating(char * sequence, char * word){
    int count = 0;
    int seq_len = strlen(sequence);
    int word_len = strlen(word);

    if(word_len > seq_len) return 0;

    for(int i = 0; i <= seq_len - word_len; i++){
        int temp_count = 0;
        int j = i;
        while(j <= seq_len - word_len){
            if(strncmp(sequence + j, word, word_len) == 0){
                temp_count++;
                j += word_len;
            } else {
                break;
            }
        }
        if(temp_count > count){
            count = temp_count;
        }
    }
    return count;
}