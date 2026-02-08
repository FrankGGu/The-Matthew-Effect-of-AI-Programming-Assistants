#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the arrays are returned as *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
int** dropDuplicateRows(int** matrix, int matrixSize, int* matrixColSize, int* returnSize, int** returnColumnSizes) {
    if (matrixSize == 0) {
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }

    int cols = matrixColSize[0];
    int* seen = (int*)calloc(matrixSize, sizeof(int));
    int* resultIndices = (int*)malloc(matrixSize * sizeof(int));
    int resultCount = 0;

    for (int i = 0; i < matrixSize; i++) {
        if (seen[i]) continue;

        resultIndices[resultCount++] = i;

        for (int j = i + 1; j < matrixSize; j++) {
            if (seen[j]) continue;

            int isDuplicate = 1;
            for (int k = 0; k < cols; k++) {
                if (matrix[i][k] != matrix[j][k]) {
                    isDuplicate = 0;
                    break;
                }
            }

            if (isDuplicate) {
                seen[j] = 1;
            }
        }
    }

    int** result = (int**)malloc(resultCount * sizeof(int*));
    *returnColumnSizes = (int*)malloc(resultCount * sizeof(int));

    for (int i = 0; i < resultCount; i++) {
        int idx = resultIndices[i];
        result[i] = (int*)malloc(cols * sizeof(int));
        memcpy(result[i], matrix[idx], cols * sizeof(int));
        (*returnColumnSizes)[i] = cols;
    }

    *returnSize = resultCount;

    free(seen);
    free(resultIndices);

    return result;
}