#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char** renameColumns(char*** data, int dataSize, int* dataColSize, int* returnSize, int** returnColumnSizes) {
    *returnSize = dataSize;
    *returnColumnSizes = malloc(dataSize * sizeof(int));
    for (int i = 0; i < dataSize; i++) {
        (*returnColumnSizes)[i] = dataColSize[i];
    }

    char** result = malloc(dataSize * sizeof(char*));
    for (int i = 0; i < dataSize; i++) {
        result[i] = malloc((dataColSize[i] + 1) * sizeof(char));
        strcpy(result[i], data[i][0]);

        for (int j = 1; j < dataColSize[i]; j++) {
            strcat(result[i], "_");
            strcat(result[i], data[i][j]);
        }
    }

    return result;
}