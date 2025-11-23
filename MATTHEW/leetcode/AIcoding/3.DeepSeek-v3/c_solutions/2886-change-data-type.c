#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the arrays are returned as *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
char*** convertDataTypes(char*** data, int dataSize, int* dataColSize, int* returnSize, int** returnColumnSizes) {
    *returnSize = dataSize;
    *returnColumnSizes = (int*)malloc(dataSize * sizeof(int));
    char*** result = (char***)malloc(dataSize * sizeof(char**));

    for (int i = 0; i < dataSize; i++) {
        (*returnColumnSizes)[i] = dataColSize[i];
        result[i] = (char**)malloc(dataColSize[i] * sizeof(char*));

        for (int j = 0; j < dataColSize[i]; j++) {
            if (j == 2) { // third column (index 2) - convert to int
                // Remove decimal part if exists
                char* value = data[i][j];
                char* dot = strchr(value, '.');
                if (dot != NULL) {
                    *dot = '\0'; // truncate at decimal point
                }
                result[i][j] = value;
            } else if (j == 3) { // fourth column (index 3) - convert to float
                // Keep as is, just copy
                result[i][j] = data[i][j];
            } else {
                // Keep other columns as is
                result[i][j] = data[i][j];
            }
        }
    }

    return result;
}