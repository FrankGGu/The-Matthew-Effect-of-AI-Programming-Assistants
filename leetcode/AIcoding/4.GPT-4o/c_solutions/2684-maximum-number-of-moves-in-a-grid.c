int maxMoves(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize, cols = gridColSize[0];
    int dp[rows][cols];
    int maxMoves = 0;

    for (int j = 0; j < cols; j++) {
        dp[0][j] = 1;
    }

    for (int i = 1; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            dp[i][j] = 0;
            if (j > 0 && grid[i][j] > grid[i - 1][j - 1]) {
                dp[i][j] = dp[i - 1][j - 1] + 1;
            }
            if (grid[i][j] > grid[i - 1][j]) {
                dp[i][j] = fmax(dp[i][j], dp[i - 1][j] + 1);
            }
            if (j < cols - 1 && grid[i][j] > grid[i - 1][j + 1]) {
                dp[i][j] = fmax(dp[i][j], dp[i - 1][j + 1] + 1);
            }
        }
    }

    for (int j = 0; j < cols; j++) {
        maxMoves = fmax(maxMoves, dp[rows - 1][j]);
    }

    return maxMoves - 1;
}