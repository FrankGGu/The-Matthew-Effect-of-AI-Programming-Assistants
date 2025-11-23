#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return strcmp(*(char**)a, *(char**)b);
}

int maximumNumberOfStringPairs(char ** words, int wordsSize){
    qsort(words, wordsSize, sizeof(char*), compare);
    int count = 0;
    for(int i = 0; i < wordsSize - 1; i++) {
        if(strcmp(words[i], words[i+1]) == 0) {
            count++;
            i++;
        }
    }
    return count;
}