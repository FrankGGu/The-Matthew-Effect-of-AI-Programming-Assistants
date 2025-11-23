#include <stdio.h>
#include <stdlib.h>

int** buildMatrix(int k, int n, int* backspace, int backspaceSize, int** target, int targetRowSize, int* targetColSizes, int** returnMatrix, int* returnSize, int** returnColumnSizes) {
    int** matrix = (int**)malloc(k * sizeof(int*));
    for (int i = 0; i < k; i++) {
        matrix[i] = (int*)malloc(n * sizeof(int));
    }
    for (int i = 0; i < k; i++) {
        for (int j = 0; j < n; j++) {
            matrix[i][j] = 0;
        }
    }
    for (int i = 0; i < backspaceSize; i++) {
        int row = backspace[i] / n;
        int col = backspace[i] % n;
        matrix[row][col] = 1;
    }
    for (int i = 0; i < targetRowSize; i++) {
        for (int j = 0; j < targetColSizes[i]; j++) {
            int row = target[i][j] / n;
            int col = target[i][j] % n;
            matrix[row][col] = 2;
        }
    }
    *returnSize = k;
    *returnColumnSizes = (int*)malloc(k * sizeof(int));
    for (int i = 0; i < k; i++) {
        (*returnColumnSizes)[i] = n;
    }
    *returnMatrix = matrix;
    return matrix;
}