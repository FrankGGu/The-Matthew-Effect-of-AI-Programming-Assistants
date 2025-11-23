#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char** oddString(char** words, int wordsSize, int* returnSize) {
    char** result = (char**)malloc(wordsSize * sizeof(char*));
    *returnSize = 0;

    for (int i = 0; i < wordsSize; i++) {
        int len = strlen(words[i]);
        char* diff = (char*)malloc((len - 1) * sizeof(char));
        for (int j = 1; j < len; j++) {
            diff[j - 1] = words[i][j] - words[i][j - 1];
        }

        int isOdd = 1;
        for (int k = 0; k < wordsSize; k++) {
            if (k == i) continue;
            int lenK = strlen(words[k]);
            if (lenK != len) {
                isOdd = 0;
                break;
            }
            char* diffK = (char*)malloc((len - 1) * sizeof(char));
            for (int j = 1; j < len; j++) {
                diffK[j - 1] = words[k][j] - words[k][j - 1];
            }
            if (memcmp(diff, diffK, (len - 1) * sizeof(char)) != 0) {
                isOdd = 0;
                free(diffK);
                break;
            }
            free(diffK);
        }

        if (isOdd) {
            result[*returnSize] = strdup(words[i]);
            (*returnSize)++;
        }

        free(diff);
    }

    return result;
}