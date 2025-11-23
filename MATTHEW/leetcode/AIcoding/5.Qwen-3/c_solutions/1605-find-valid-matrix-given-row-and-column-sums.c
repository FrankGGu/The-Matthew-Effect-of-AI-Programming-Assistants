#include <stdio.h>
#include <stdlib.h>

int** findValidMatrix(int* rowSum, int rowSumSize, int* colSum, int colSumSize, int* returnSize, int** returnColumnSizes) {
    int** matrix = (int**)malloc(rowSumSize * sizeof(int*));
    *returnColumnSizes = (int*)malloc(rowSumSize * sizeof(int));
    *returnSize = rowSumSize;
    for (int i = 0; i < rowSumSize; i++) {
        matrix[i] = (int*)malloc(colSumSize * sizeof(int));
        (*returnColumnSizes)[i] = colSumSize;
    }

    for (int i = 0; i < rowSumSize; i++) {
        for (int j = 0; j < colSumSize; j++) {
            matrix[i][j] = rowSum[i] < colSum[j] ? rowSum[i] : colSum[j];
            rowSum[i] -= matrix[i][j];
            colSum[j] -= matrix[i][j];
        }
    }

    return matrix;
}