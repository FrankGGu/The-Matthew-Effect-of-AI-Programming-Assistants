typedef struct {
    int** sum;
    int rows;
    int cols;
} NumMatrix;

NumMatrix* numMatrixCreate(int** matrix, int matrixSize, int* matrixColSize) {
    NumMatrix* obj = (NumMatrix*)malloc(sizeof(NumMatrix));
    obj->rows = matrixSize;
    obj->cols = *matrixColSize;
    obj->sum = (int**)malloc((matrixSize + 1) * sizeof(int*));
    for (int i = 0; i <= matrixSize; i++) {
        obj->sum[i] = (int*)malloc(((*matrixColSize) + 1) * sizeof(int));
        for (int j = 0; j <= *matrixColSize; j++) {
            obj->sum[i][j] = 0;
        }
    }

    for (int i = 1; i <= matrixSize; i++) {
        for (int j = 1; j <= *matrixColSize; j++) {
            obj->sum[i][j] = matrix[i - 1][j - 1] + obj->sum[i - 1][j] + obj->sum[i][j - 1] - obj->sum[i - 1][j - 1];
        }
    }
    return obj;
}

int numMatrixSumRegion(NumMatrix* obj, int row1, int col1, int row2, int col2) {
    return obj->sum[row2 + 1][col2 + 1] - obj->sum[row1][col2 + 1] - obj->sum[row2 + 1][col1] + obj->sum[row1][col1];
}

void numMatrixFree(NumMatrix* obj) {
    for (int i = 0; i <= obj->rows; i++) {
        free(obj->sum[i]);
    }
    free(obj->sum);
    free(obj);
}