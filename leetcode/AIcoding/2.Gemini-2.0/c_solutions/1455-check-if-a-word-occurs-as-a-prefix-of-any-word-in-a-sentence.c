#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int isPrefixOfWord(char * sentence, char * searchWord){
    int word_count = 1;
    int search_len = strlen(searchWord);
    int sen_len = strlen(sentence);
    int i = 0;
    while(i < sen_len){
        int j = 0;
        int k = i;
        while(k < sen_len && sentence[k] != ' '){
            if(j < search_len && sentence[k] == searchWord[j]){
                j++;
            } else {
                while(k < sen_len && sentence[k] != ' ') k++;
                break;
            }
            k++;
        }
        if(j == search_len){
            return word_count;
        }
        while(i < sen_len && sentence[i] != ' ') i++;
        if(i < sen_len) i++;
        word_count++;
    }
    return -1;
}