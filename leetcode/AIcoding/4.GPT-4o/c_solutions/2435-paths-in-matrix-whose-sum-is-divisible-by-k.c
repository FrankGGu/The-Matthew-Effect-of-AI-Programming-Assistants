int numberOfPaths(int** grid, int gridSize, int* gridColSize, int k) {
    int mod = 1000000007;
    int rows = gridSize, cols = *gridColSize;
    long long dp[rows][cols][k];

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            for (int r = 0; r < k; r++) {
                dp[i][j][r] = 0;
            }
        }
    }

    dp[0][0][grid[0][0] % k] = 1;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            for (int r = 0; r < k; r++) {
                if (i > 0) {
                    dp[i][j][(r + grid[i][j]) % k] = (dp[i][j][(r + grid[i][j]) % k] + dp[i - 1][j][r]) % mod;
                }
                if (j > 0) {
                    dp[i][j][(r + grid[i][j]) % k] = (dp[i][j][(r + grid[i][j]) % k] + dp[i][j - 1][r]) % mod;
                }
            }
        }
    }

    return dp[rows - 1][cols - 1][0];
}