#include <stdio.h>
#include <stdlib.h>

int** modifyMatrix(int** matrix, int matrixSize, int* matrixColSize, int x, int y, int val, int* returnSize, int** returnColumnSizes) {
    int** result = (int**)malloc(matrixSize * sizeof(int*));
    *returnColumnSizes = (int*)malloc(matrixSize * sizeof(int));
    for (int i = 0; i < matrixSize; i++) {
        result[i] = (int*)malloc(matrixColSize[i] * sizeof(int));
        (*returnColumnSizes)[i] = matrixColSize[i];
        for (int j = 0; j < matrixColSize[i]; j++) {
            if (i == x || j == y) {
                result[i][j] = val;
            } else {
                result[i][j] = matrix[i][j];
            }
        }
    }
    *returnSize = matrixSize;
    return result;
}