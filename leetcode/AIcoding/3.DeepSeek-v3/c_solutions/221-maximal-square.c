int maximalSquare(char** matrix, int matrixSize, int* matrixColSize) {
    if (matrixSize == 0) return 0;
    int cols = matrixColSize[0];
    int dp[matrixSize + 1][cols + 1];
    memset(dp, 0, sizeof(dp));
    int maxSide = 0;

    for (int i = 1; i <= matrixSize; i++) {
        for (int j = 1; j <= cols; j++) {
            if (matrix[i-1][j-1] == '1') {
                dp[i][j] = fmin(fmin(dp[i-1][j], dp[i][j-1]), dp[i-1][j-1]) + 1;
                if (dp[i][j] > maxSide) {
                    maxSide = dp[i][j];
                }
            }
        }
    }

    return maxSide * maxSide;
}