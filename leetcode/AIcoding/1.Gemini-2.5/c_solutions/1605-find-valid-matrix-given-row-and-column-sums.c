#include <stdlib.h>
#include <string.h>
#include <math.h>

int** restoreMatrix(int* rowSum, int rowSumSize, int* colSum, int colSumSize, int* returnSize, int** returnColumnSizes) {
    int** matrix = (int**)malloc(rowSumSize * sizeof(int*));
    *returnSize = rowSumSize;
    *returnColumnSizes = (int*)malloc(rowSumSize * sizeof(int));

    for (int i = 0; i < rowSumSize; i++) {
        matrix[i] = (int*)malloc(colSumSize * sizeof(int));
        (*returnColumnSizes)[i] = colSumSize;
        for (int j = 0; j < colSumSize; j++) {
            int val = fmin(rowSum[i], colSum[j]);
            matrix[i][j] = val;
            rowSum[i] -= val;
            colSum[j] -= val;
        }
    }

    return matrix;
}