int maxMoves(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize;
    int n = gridColSize[0];

    int dp[m][n];
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            dp[i][j] = 0;
        }
    }

    for (int j = n - 2; j >= 0; j--) {
        for (int i = 0; i < m; i++) {
            if (i > 0 && grid[i][j] < grid[i-1][j+1]) {
                dp[i][j] = fmax(dp[i][j], dp[i-1][j+1] + 1);
            }
            if (grid[i][j] < grid[i][j+1]) {
                dp[i][j] = fmax(dp[i][j], dp[i][j+1] + 1);
            }
            if (i < m - 1 && grid[i][j] < grid[i+1][j+1]) {
                dp[i][j] = fmax(dp[i][j], dp[i+1][j+1] + 1);
            }
        }
    }

    int maxMoves = 0;
    for (int i = 0; i < m; i++) {
        maxMoves = fmax(maxMoves, dp[i][0]);
    }
    return maxMoves;
}