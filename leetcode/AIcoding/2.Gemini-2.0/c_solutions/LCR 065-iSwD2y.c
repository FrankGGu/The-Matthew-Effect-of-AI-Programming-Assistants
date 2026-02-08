#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return strlen(*(char**)b) - strlen(*(char**)a);
}

int minimumLengthEncoding(char ** words, int wordsSize){
    qsort(words, wordsSize, sizeof(char*), compare);
    int len = 0;
    for (int i = 0; i < wordsSize; i++) {
        int found = 0;
        for (int j = 0; j < i; j++) {
            int word1_len = strlen(words[i]);
            int word2_len = strlen(words[j]);
            if (word2_len >= word1_len && strcmp(words[j] + (word2_len - word1_len), words[i]) == 0) {
                found = 1;
                break;
            }
        }
        if (!found) {
            len += strlen(words[i]) + 1;
        }
    }
    return len;
}