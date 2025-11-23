#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countPrefixes(char ** words, int wordsSize, char * s){
    int count = 0;
    int s_len = strlen(s);
    for(int i = 0; i < wordsSize; i++){
        int word_len = strlen(words[i]);
        if(word_len <= s_len && strncmp(words[i], s, word_len) == 0){
            count++;
        }
    }
    return count;
}