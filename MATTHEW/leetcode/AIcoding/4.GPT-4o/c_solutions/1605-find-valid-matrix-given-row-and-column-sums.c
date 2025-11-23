int** restoreMatrix(int* rowSum, int rowSumSize, int* colSum, int colSumSize, int** returnSize) {
    int** result = (int**)malloc(rowSumSize * sizeof(int*));
    for (int i = 0; i < rowSumSize; i++) {
        result[i] = (int*)malloc(colSumSize * sizeof(int));
    }

    for (int i = 0; i < rowSumSize; i++) {
        for (int j = 0; j < colSumSize; j++) {
            result[i][j] = rowSum[i] < colSum[j] ? rowSum[i] : colSum[j];
            rowSum[i] -= result[i][j];
            colSum[j] -= result[i][j];
        }
    }

    *returnSize = rowSumSize;
    return result;
}