#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int** restoreMatrix(int* rowSum, int rowSumSize, int* colSum, int colSumSize, int* returnSize, int** returnColumnSizes){
    int** matrix = (int**)malloc(rowSumSize * sizeof(int*));
    *returnColumnSizes = (int*)malloc(rowSumSize * sizeof(int));

    for (int i = 0; i < rowSumSize; i++) {
        matrix[i] = (int*)malloc(colSumSize * sizeof(int));
        (*returnColumnSizes)[i] = colSumSize;
        for (int j = 0; j < colSumSize; j++) {
            matrix[i][j] = 0;
        }
    }

    *returnSize = rowSumSize;

    for (int i = 0; i < rowSumSize; i++) {
        for (int j = 0; j < colSumSize; j++) {
            int val = (rowSum[i] < colSum[j]) ? rowSum[i] : colSum[j];
            matrix[i][j] = val;
            rowSum[i] -= val;
            colSum[j] -= val;
        }
    }

    return matrix;
}