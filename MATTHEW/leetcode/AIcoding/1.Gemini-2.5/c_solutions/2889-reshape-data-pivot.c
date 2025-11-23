#include <stdlib.h>

int** transpose(int** matrix, int matrixSize, int* matrixColSize, int* returnSize, int** returnColumnSizes) {
    if (matrixSize == 0 || matrixColSize[0] == 0) {
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }

    int originalRows = matrixSize;
    int originalCols = matrixColSize[0];

    *returnSize = originalCols;
    *returnColumnSizes = (int*) malloc(sizeof(int) * originalCols);
    if (*returnColumnSizes == NULL) {
        *returnSize = 0;
        return NULL;
    }

    int** transposedMatrix = (int**) malloc(sizeof(int*) * originalCols);
    if (transposedMatrix == NULL) {
        free(*returnColumnSizes);
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }

    for (int i = 0; i < originalCols; i++) {
        (*returnColumnSizes)[i] = originalRows;
        transposedMatrix[i] = (int*) malloc(sizeof(int) * originalRows);
        if (transposedMatrix[i] == NULL) {
            for (int j = 0; j < i; j++) {
                free(transposedMatrix[j]);
            }
            free(transposedMatrix);
            free(*returnColumnSizes);
            *returnSize = 0;
            *returnColumnSizes = NULL;
            return NULL;
        }
    }

    for (int r = 0; r < originalRows; r++) {
        for (int c = 0; c < originalCols; c++) {
            transposedMatrix[c][r] = matrix[r][c];
        }
    }

    return transposedMatrix;
}