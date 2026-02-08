int maxSideLength(int** mat, int matSize, int* matColSize, int threshold) {
    int maxSide = 0;
    int rows = matSize, cols = *matColSize;
    int prefixSum[rows + 1][cols + 1];

    for (int i = 0; i <= rows; i++) {
        for (int j = 0; j <= cols; j++) {
            prefixSum[i][j] = 0;
        }
    }

    for (int i = 1; i <= rows; i++) {
        for (int j = 1; j <= cols; j++) {
            prefixSum[i][j] = mat[i - 1][j - 1] + prefixSum[i - 1][j] + prefixSum[i][j - 1] - prefixSum[i - 1][j - 1];
        }
    }

    for (int side = 1; side <= fmin(rows, cols); side++) {
        for (int i = side; i <= rows; i++) {
            for (int j = side; j <= cols; j++) {
                int sum = prefixSum[i][j] - prefixSum[i - side][j] - prefixSum[i][j - side] + prefixSum[i - side][j - side];
                if (sum <= threshold) {
                    maxSide = side;
                }
            }
        }
    }

    return maxSide;
}