int largest1BorderedSquare(int** grid, int gridSize, int* gridColSize) {
    int maxSize = 0;
    int rows = gridSize, cols = *gridColSize;
    int dp[rows + 1][cols + 1];
    memset(dp, 0, sizeof(dp));

    for (int i = 1; i <= rows; i++) {
        for (int j = 1; j <= cols; j++) {
            if (grid[i - 1][j - 1] == 1) {
                dp[i][j] = 1 + fmin(dp[i - 1][j], fmin(dp[i][j - 1], dp[i - 1][j - 1]));
                for (int size = dp[i][j]; size > 0; size--) {
                    if (dp[i][j - size + 1] >= size && dp[i - size + 1][j] >= size) {
                        maxSize = fmax(maxSize, size);
                        break;
                    }
                }
            }
        }
    }
    return maxSize * maxSize;
}