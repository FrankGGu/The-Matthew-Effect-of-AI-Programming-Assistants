#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char ** stringMatching(char ** words, int wordsSize, int* returnSize){
    char **result = (char **)malloc(wordsSize * sizeof(char *));
    *returnSize = 0;

    for (int i = 0; i < wordsSize; i++) {
        for (int j = 0; j < wordsSize; j++) {
            if (i != j) {
                if (strstr(words[j], words[i]) != NULL) {
                    result[*returnSize] = words[i];
                    (*returnSize)++;
                    break;
                }
            }
        }
    }

    char **finalResult = (char **)malloc(*returnSize * sizeof(char *));
    for(int i=0; i<*returnSize; i++){
        finalResult[i] = strdup(result[i]);
    }

    free(result);

    return finalResult;
}