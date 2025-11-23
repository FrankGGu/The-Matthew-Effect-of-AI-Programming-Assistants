int minSum(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize, n = gridColSize[0];
    int total = 0;
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            total += grid[i][j];
        }
    }

    int half = total / 2;
    int dp[m+1][n+1][half+1];
    for (int i = 0; i <= m; i++) {
        for (int j = 0; j <= n; j++) {
            for (int k = 0; k <= half; k++) {
                dp[i][j][k] = 0;
            }
        }
    }
    dp[0][0][0] = 1;

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            int val = grid[i][j];
            for (int k = half; k >= 0; k--) {
                for (int r = 0; r <= i; r++) {
                    for (int c = 0; c <= j; c++) {
                        if (dp[r][c][k] && k + val <= half) {
                            dp[i+1][j+1][k+val] = 1;
                            dp[r][j+1][k+val] = 1;
                            dp[i+1][c][k+val] = 1;
                        }
                    }
                }
            }
        }
    }

    for (int k = half; k >= 0; k--) {
        for (int i = 0; i <= m; i++) {
            for (int j = 0; j <= n; j++) {
                if (dp[i][j][k]) {
                    return total - 2 * k;
                }
            }
        }
    }
    return total;
}