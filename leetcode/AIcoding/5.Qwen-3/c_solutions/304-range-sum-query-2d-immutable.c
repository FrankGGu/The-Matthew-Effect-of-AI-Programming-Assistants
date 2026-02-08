#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int** dp;
    int rows;
    int cols;
} NumMatrix;

NumMatrix* numMatrixCreate(int** matrix, int matrixSize, int* matrixColSize) {
    int rows = matrixSize;
    int cols = matrixColSize[0];
    NumMatrix* obj = (NumMatrix*)malloc(sizeof(NumMatrix));
    obj->dp = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        obj->dp[i] = (int*)malloc(cols * sizeof(int));
    }
    obj->rows = rows;
    obj->cols = cols;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (i == 0 && j == 0) {
                obj->dp[i][j] = matrix[i][j];
            } else if (i == 0) {
                obj->dp[i][j] = obj->dp[i][j - 1] + matrix[i][j];
            } else if (j == 0) {
                obj->dp[i][j] = obj->dp[i - 1][j] + matrix[i][j];
            } else {
                obj->dp[i][j] = matrix[i][j] + obj->dp[i - 1][j] + obj->dp[i][j - 1] - obj->dp[i - 1][j - 1];
            }
        }
    }

    return obj;
}

int numMatrixSumRegion(NumMatrix* obj, int row1, int col1, int row2, int col2) {
    int total = obj->dp[row2][col2];
    int left = (col1 > 0) ? obj->dp[row2][col1 - 1] : 0;
    int top = (row1 > 0) ? obj->dp[row1 - 1][col2] : 0;
    int diagonal = (row1 > 0 && col1 > 0) ? obj->dp[row1 - 1][col1 - 1] : 0;
    return total - left - top + diagonal;
}

void numMatrixFree(NumMatrix* obj) {
    for (int i = 0; i < obj->rows; i++) {
        free(obj->dp[i]);
    }
    free(obj->dp);
    free(obj);
}