#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int **sum;
} NumMatrix;

NumMatrix* numMatrixCreate(int** matrix, int matrixSize, int* matrixColSize) {
    NumMatrix* obj = (NumMatrix*)malloc(sizeof(NumMatrix));
    if (matrixSize == 0 || matrixColSize[0] == 0) {
        obj->sum = NULL;
        return obj;
    }
    int rows = matrixSize;
    int cols = matrixColSize[0];
    obj->sum = (int**)malloc(sizeof(int*) * (rows + 1));
    for (int i = 0; i <= rows; i++) {
        obj->sum[i] = (int*)malloc(sizeof(int) * (cols + 1));
        for (int j = 0; j <= cols; j++) {
            obj->sum[i][j] = 0;
        }
    }

    for (int i = 1; i <= rows; i++) {
        for (int j = 1; j <= cols; j++) {
            obj->sum[i][j] = obj->sum[i - 1][j] + obj->sum[i][j - 1] - obj->sum[i - 1][j - 1] + matrix[i - 1][j - 1];
        }
    }
    return obj;
}

int numMatrixSumRegion(NumMatrix* obj, int row1, int col1, int row2, int col2) {
    if (obj == NULL || obj->sum == NULL) return 0;
    return obj->sum[row2 + 1][col2 + 1] - obj->sum[row1][col2 + 1] - obj->sum[row2 + 1][col1] + obj->sum[row1][col1];
}

void numMatrixFree(NumMatrix* obj) {
    if (obj == NULL) return;
    if (obj->sum != NULL) {
        for (int i = 0; i < 1000; i++) {
            if(obj->sum[i] != NULL){
                free(obj->sum[i]);
            } else {
                break;
            }
        }
        free(obj->sum);
    }
    free(obj);
}