typedef struct {
    int** dp;
    int rows;
    int cols;
} NumMatrix;

NumMatrix* numMatrixCreate(int** matrix, int matrixSize, int* matrixColSize) {
    if (matrixSize == 0 || matrixColSize[0] == 0) {
        NumMatrix* obj = (NumMatrix*)malloc(sizeof(NumMatrix));
        obj->dp = NULL;
        obj->rows = 0;
        obj->cols = 0;
        return obj;
    }

    NumMatrix* obj = (NumMatrix*)malloc(sizeof(NumMatrix));
    obj->rows = matrixSize;
    obj->cols = matrixColSize[0];
    obj->dp = (int**)malloc((obj->rows + 1) * sizeof(int*));
    for (int i = 0; i <= obj->rows; i++) {
        obj->dp[i] = (int*)calloc((obj->cols + 1), sizeof(int));
    }

    for (int i = 0; i < obj->rows; i++) {
        for (int j = 0; j < obj->cols; j++) {
            obj->dp[i + 1][j + 1] = obj->dp[i + 1][j] + obj->dp[i][j + 1] - obj->dp[i][j] + matrix[i][j];
        }
    }

    return obj;
}

int numMatrixSumRegion(NumMatrix* obj, int row1, int col1, int row2, int col2) {
    return obj->dp[row2 + 1][col2 + 1] - obj->dp[row1][col2 + 1] - obj->dp[row2 + 1][col1] + obj->dp[row1][col1];
}

void numMatrixFree(NumMatrix* obj) {
    if (obj->dp) {
        for (int i = 0; i <= obj->rows; i++) {
            free(obj->dp[i]);
        }
        free(obj->dp);
    }
    free(obj);
}