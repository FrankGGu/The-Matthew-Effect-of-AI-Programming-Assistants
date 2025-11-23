#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char **twoEditWords(char **queries, int queriesSize, char **dictionary, int dictionarySize, int *returnSize) {
    char **result = (char **)malloc(queriesSize * sizeof(char *));
    int count = 0;

    for (int i = 0; i < queriesSize; i++) {
        int diff = 0;
        for (int j = 0; j < strlen(queries[i]); j++) {
            if (queries[i][j] != dictionary[j][i]) {
                diff++;
                if (diff > 2) break;
            }
        }
        if (diff <= 2) {
            result[count++] = queries[i];
        }
    }

    *returnSize = count;
    return result;
}