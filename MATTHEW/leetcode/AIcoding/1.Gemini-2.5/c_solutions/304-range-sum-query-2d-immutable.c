#include <stdlib.h>

typedef struct {
    long long** sum;
    int rows;
    int cols;
} NumMatrix;

NumMatrix* numMatrixCreate(int** matrix, int matrixSize, int* matrixColSize) {
    NumMatrix* obj = (NumMatrix*)malloc(sizeof(NumMatrix));

    if (matrixSize == 0 || *matrixColSize == 0) {
        obj->sum = NULL;
        obj->rows = 0;
        obj->cols = 0;
        return obj;
    }

    int m = matrixSize;
    int n = *matrixColSize;

    obj->rows = m;
    obj->cols = n;

    obj->sum = (long long**)malloc((m + 1) * sizeof(long long*));
    for (int i = 0; i <= m; i++) {
        obj->sum[i] = (long long*)malloc((n + 1) * sizeof(long long));
        for (int j = 0; j <= n; j++) {
            obj->sum[i][j] = 0;
        }
    }

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            obj->sum[i + 1][j + 1] = (long long)matrix[i][j] + obj->sum[i][j + 1] + obj->sum[i + 1][j] - obj->sum[i][j];
        }
    }

    return obj;
}

int numMatrixSumRegion(NumMatrix* obj, int row1, int col1, int row2, int col2) {
    if (obj == NULL || obj->sum == NULL) {
        return 0;
    }

    long long result = obj->sum[row2 + 1][col2 + 1] - obj->sum[row1][col2 + 1] - obj->sum[row2 + 1][col1] + obj->sum[row1][col1];

    return (int)result;
}

void numMatrixFree(NumMatrix* obj) {
    if (obj == NULL) {
        return;
    }
    if (obj->sum != NULL) {
        for (int i = 0; i <= obj->rows; i++) {
            free(obj->sum[i]);
        }
        free(obj->sum);
    }
    free(obj);
}