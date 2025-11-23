#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int **sum;
} NumMatrix;

NumMatrix* numMatrixCreate(int** matrix, int matrixSize, int* matrixColSize) {
    NumMatrix* obj = (NumMatrix*)malloc(sizeof(NumMatrix));
    if (obj == NULL) return NULL;

    if (matrixSize == 0 || matrixColSize == NULL || *matrixColSize == 0) {
        obj->sum = NULL;
        return obj;
    }

    obj->sum = (int**)malloc((matrixSize + 1) * sizeof(int*));
    if (obj->sum == NULL) {
        free(obj);
        return NULL;
    }

    for (int i = 0; i <= matrixSize; i++) {
        obj->sum[i] = (int*)calloc(*matrixColSize + 1, sizeof(int));
        if (obj->sum[i] == NULL) {
            for (int j = 0; j < i; j++) {
                free(obj->sum[j]);
            }
            free(obj->sum);
            free(obj);
            return NULL;
        }
    }

    for (int i = 1; i <= matrixSize; i++) {
        for (int j = 1; j <= *matrixColSize; j++) {
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
        int rows = 0;
        while(obj->sum[rows] != NULL){
            rows++;
            if(rows > 500) break;
        }
        for (int i = 0; i < rows; i++) {
            free(obj->sum[i]);
        }
        free(obj->sum);
    }
    free(obj);
}