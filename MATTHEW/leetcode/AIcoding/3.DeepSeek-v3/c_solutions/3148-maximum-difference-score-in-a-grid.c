int maxScore(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize, n = gridColSize[0];
    int dp[m][n];
    int maxScore = INT_MIN;

    dp[m-1][n-1] = grid[m-1][n-1];

    for (int i = m-1; i >= 0; i--) {
        for (int j = n-1; j >= 0; j--) {
            if (i == m-1 && j == n-1) continue;

            dp[i][j] = grid[i][j];
            int maxRight = INT_MIN, maxDown = INT_MIN;

            if (j + 1 < n) maxRight = dp[i][j+1];
            if (i + 1 < m) maxDown = dp[i+1][j];

            int maxVal = fmax(maxRight, maxDown);
            dp[i][j] = fmax(dp[i][j], maxVal);

            if (j + 1 < n) maxScore = fmax(maxScore, dp[i][j+1] - grid[i][j]);
            if (i + 1 < m) maxScore = fmax(maxScore, dp[i+1][j] - grid[i][j]);
        }
    }

    return maxScore;
}