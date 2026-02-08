int numberOfPaths(int** grid, int gridSize, int* gridColSize, int k) {
    int MOD = 1000000007;
    int m = gridSize;
    int n = gridColSize[0];

    int dp[m][n][k];
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            for (int r = 0; r < k; r++) {
                dp[i][j][r] = 0;
            }
        }
    }

    dp[0][0][grid[0][0] % k] = 1;

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            for (int r = 0; r < k; r++) {
                if (dp[i][j][r] == 0) continue;

                if (i + 1 < m) {
                    int new_r = (r + grid[i+1][j]) % k;
                    dp[i+1][j][new_r] = (dp[i+1][j][new_r] + dp[i][j][r]) % MOD;
                }

                if (j + 1 < n) {
                    int new_r = (r + grid[i][j+1]) % k;
                    dp[i][j+1][new_r] = (dp[i][j+1][new_r] + dp[i][j][r]) % MOD;
                }
            }
        }
    }

    return dp[m-1][n-1][0];
}