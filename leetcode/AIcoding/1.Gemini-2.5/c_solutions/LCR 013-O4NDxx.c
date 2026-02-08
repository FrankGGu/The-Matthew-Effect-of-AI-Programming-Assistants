#include <stdlib.h>

typedef struct {
    int** sum;
    int rows;
    int cols;
} NumMatrix;

NumMatrix* numMatrixCreate(int** matrix, int matrixSize, int* matrixColSize) {
    NumMatrix* obj = (NumMatrix*)malloc(sizeof(NumMatrix));
    if (obj == NULL) {
        return NULL;
    }

    obj->rows = matrixSize;
    obj->cols = matrixColSize[0];

    obj->sum = (int**)malloc((obj->rows + 1) * sizeof(int*));
    if (obj->sum == NULL) {
        free(obj);
        return NULL;
    }

    for (int i = 0; i <= obj->rows; ++i) {
        obj->sum[i] = (int*)malloc((obj->cols + 1) * sizeof(int));
        if (obj->sum[i] == NULL) {
            for (int k = 0; k < i; ++k) {
                free(obj->sum[k]);
            }
            free(obj->sum);
            free(obj);
            return NULL;
        }
        obj->sum[i][0] = 0; 
    }

    for (int j = 1; j <= obj->cols; ++j) {
        obj->sum[0][j] = 0;
    }

    for (int i = 1; i <= obj->rows; ++i) {
        for (int j = 1; j <= obj->cols; ++j) {
            obj->sum[i][j] = matrix[i-1][j-1] + obj->sum[i-1][j] + obj->sum[i][j-1] - obj->sum[i-1][j-1];
        }
    }

    return obj;
}

int numMatrixSumRegion(NumMatrix* obj, int row1, int col1, int row2, int col2) {
    return obj->sum[row2+1][col2+1] - obj->sum[row1][col2+1] - obj->sum[row2+1][col1] + obj->sum[row1][col1];
}

void numMatrixFree(NumMatrix* obj) {
    if (obj == NULL) {
        return;
    }
    if (obj->sum != NULL) {
        for (int i = 0; i <= obj->rows; ++i) {
            free(obj->sum[i]);
        }
        free(obj->sum);
    }
    free(obj);
}