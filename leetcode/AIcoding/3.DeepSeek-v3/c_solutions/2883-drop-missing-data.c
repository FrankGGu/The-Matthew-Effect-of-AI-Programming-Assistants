#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the arrays are returned as *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
char*** dropMissingData(char*** data, int dataSize, int* dataColSize, int* returnSize, int** returnColumnSizes) {
    // First, count how many rows have no missing data
    int validRows = 0;
    for (int i = 0; i < dataSize; i++) {
        int hasMissing = 0;
        for (int j = 0; j < dataColSize[i]; j++) {
            if (data[i][j] == NULL || strcmp(data[i][j], "") == 0) {
                hasMissing = 1;
                break;
            }
        }
        if (!hasMissing) {
            validRows++;
        }
    }

    // Allocate memory for result
    *returnSize = validRows;
    char*** result = (char***)malloc(validRows * sizeof(char**));
    *returnColumnSizes = (int*)malloc(validRows * sizeof(int));

    // Copy valid rows to result
    int idx = 0;
    for (int i = 0; i < dataSize; i++) {
        int hasMissing = 0;
        for (int j = 0; j < dataColSize[i]; j++) {
            if (data[i][j] == NULL || strcmp(data[i][j], "") == 0) {
                hasMissing = 1;
                break;
            }
        }
        if (!hasMissing) {
            (*returnColumnSizes)[idx] = dataColSize[i];
            result[idx] = (char**)malloc(dataColSize[i] * sizeof(char*));
            for (int j = 0; j < dataColSize[i]; j++) {
                result[idx][j] = (char*)malloc((strlen(data[i][j]) + 1) * sizeof(char));
                strcpy(result[idx][j], data[i][j]);
            }
            idx++;
        }
    }

    return result;
}