int** matrixBlockSum(int** mat, int matSize, int* matColSize, int K, int* returnSize, int** returnColumnSizes) {
    int rows = matSize, cols = *matColSize;
    int** result = (int**)malloc(rows * sizeof(int*));
    int** prefixSum = (int**)malloc((rows + 1) * sizeof(int*));

    for (int i = 0; i < rows + 1; i++) {
        prefixSum[i] = (int*)malloc((cols + 1) * sizeof(int));
    }

    for (int i = 0; i < rows + 1; i++) {
        for (int j = 0; j < cols + 1; j++) {
            prefixSum[i][j] = 0;
        }
    }

    for (int i = 1; i <= rows; i++) {
        for (int j = 1; j <= cols; j++) {
            prefixSum[i][j] = mat[i - 1][j - 1] + prefixSum[i - 1][j] + prefixSum[i][j - 1] - prefixSum[i - 1][j - 1];
        }
    }

    *returnSize = rows;
    *returnColumnSizes = (int*)malloc(rows * sizeof(int));

    for (int i = 0; i < rows; i++) {
        result[i] = (int*)malloc(cols * sizeof(int));
        (*returnColumnSizes)[i] = cols;
        for (int j = 0; j < cols; j++) {
            int r1 = fmax(0, i - K), c1 = fmax(0, j - K);
            int r2 = fmin(rows - 1, i + K), c2 = fmin(cols - 1, j + K);
            result[i][j] = prefixSum[r2 + 1][c2 + 1] - prefixSum[r1][c2 + 1] - prefixSum[r2 + 1][c1] + prefixSum[r1][c1];
        }
    }

    for (int i = 0; i < rows + 1; i++) {
        free(prefixSum[i]);
    }
    free(prefixSum);

    return result;
}