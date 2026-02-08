typedef struct {
    int** sums;
    int rows;
    int cols;
} NumMatrix;

NumMatrix* numMatrixCreate(int** matrix, int matrixSize, int* matrixColSize) {
    NumMatrix* obj = (NumMatrix*)malloc(sizeof(NumMatrix));
    obj->rows = matrixSize;
    obj->cols = matrixColSize[0];
    obj->sums = (int**)malloc((obj->rows + 1) * sizeof(int*));
    for (int i = 0; i <= obj->rows; i++) {
        obj->sums[i] = (int*)calloc(obj->cols + 1, sizeof(int));
    }

    for (int i = 0; i < obj->rows; i++) {
        for (int j = 0; j < obj->cols; j++) {
            obj->sums[i + 1][j + 1] = obj->sums[i][j + 1] + obj->sums[i + 1][j] - obj->sums[i][j] + matrix[i][j];
        }
    }

    return obj;
}

int numMatrixSumRegion(NumMatrix* obj, int row1, int col1, int row2, int col2) {
    return obj->sums[row2 + 1][col2 + 1] - obj->sums[row1][col2 + 1] - obj->sums[row2 + 1][col1] + obj->sums[row1][col1];
}

void numMatrixFree(NumMatrix* obj) {
    for (int i = 0; i <= obj->rows; i++) {
        free(obj->sums[i]);
    }
    free(obj->sums);
    free(obj);
}