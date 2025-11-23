typedef struct {
    int** sumMatrix;
    int rows;
    int cols;
} NumMatrix;

NumMatrix* numMatrixCreate(int** matrix, int matrixSize, int* matrixColSize) {
    NumMatrix* nm = (NumMatrix*)malloc(sizeof(NumMatrix));
    nm->rows = matrixSize;
    nm->cols = matrixColSize[0];
    nm->sumMatrix = (int**)malloc((matrixSize + 1) * sizeof(int*));
    for (int i = 0; i <= matrixSize; i++) {
        nm->sumMatrix[i] = (int*)malloc((matrixColSize[0] + 1) * sizeof(int));
        for (int j = 0; j <= matrixColSize[0]; j++) {
            nm->sumMatrix[i][j] = 0;
        }
    }
    for (int i = 1; i <= matrixSize; i++) {
        for (int j = 1; j <= matrixColSize[0]; j++) {
            nm->sumMatrix[i][j] = matrix[i - 1][j - 1] + nm->sumMatrix[i - 1][j] + nm->sumMatrix[i][j - 1] - nm->sumMatrix[i - 1][j - 1];
        }
    }
    return nm;
}

int numMatrixSumRegion(NumMatrix* obj, int row1, int col1, int row2, int col2) {
    return obj->sumMatrix[row2 + 1][col2 + 1] - obj->sumMatrix[row1][col2 + 1] - obj->sumMatrix[row2 + 1][col1] + obj->sumMatrix[row1][col1];
}

void numMatrixFree(NumMatrix* obj) {
    for (int i = 0; i <= obj->rows; i++) {
        free(obj->sumMatrix[i]);
    }
    free(obj->sumMatrix);
    free(obj);
}