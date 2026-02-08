int countPyramids(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize, n = gridColSize[0];
    int** dp = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        dp[i] = (int*)malloc(n * sizeof(int));
        memcpy(dp[i], grid[i], n * sizeof(int));
    }

    int res = 0;

    for (int i = m - 2; i >= 0; i--) {
        for (int j = 1; j < n - 1; j++) {
            if (dp[i][j] == 1 && dp[i+1][j] > 0) {
                dp[i][j] = 1 + fmin(dp[i+1][j-1], fmin(dp[i+1][j], dp[i+1][j+1]));
                res += dp[i][j] - 1;
            }
        }
    }

    for (int i = 0; i < m; i++) {
        memcpy(dp[i], grid[i], n * sizeof(int));
    }

    for (int i = 1; i < m; i++) {
        for (int j = 1; j < n - 1; j++) {
            if (dp[i][j] == 1 && dp[i-1][j] > 0) {
                dp[i][j] = 1 + fmin(dp[i-1][j-1], fmin(dp[i-1][j], dp[i-1][j+1]));
                res += dp[i][j] - 1;
            }
        }
    }

    for (int i = 0; i < m; i++) {
        free(dp[i]);
    }
    free(dp);

    return res;
}