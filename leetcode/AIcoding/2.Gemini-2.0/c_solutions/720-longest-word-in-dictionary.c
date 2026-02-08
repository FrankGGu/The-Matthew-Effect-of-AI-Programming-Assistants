#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return strlen(*(char **)b) - strlen(*(char **)a);
}

char * longestWord(char ** words, int wordsSize){
    qsort(words, wordsSize, sizeof(char *), compare);

    for (int i = 0; i < wordsSize; i++) {
        int len = strlen(words[i]);
        int found = 1;
        for (int j = 1; j < len; j++) {
            char sub[j + 1];
            strncpy(sub, words[i], j);
            sub[j] = '\0';

            int sub_found = 0;
            for (int k = 0; k < wordsSize; k++) {
                if (strcmp(sub, words[k]) == 0) {
                    sub_found = 1;
                    break;
                }
            }
            if (!sub_found) {
                found = 0;
                break;
            }
        }
        if (found) {
            char* result = (char*)malloc(strlen(words[i]) + 1);
            strcpy(result, words[i]);
            return result;
        }
    }
    return "";
}