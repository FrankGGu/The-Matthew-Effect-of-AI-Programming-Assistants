int countPaths(int** grid, int gridSize, int* gridColSize, int x) {
    int mod = 1e9 + 7;
    int n = gridSize, m = *gridColSize;
    int*** dp = (int***)malloc(n * sizeof(int**));
    for (int i = 0; i < n; i++) {
        dp[i] = (int**)malloc(m * sizeof(int*));
        for (int j = 0; j < m; j++) {
            dp[i][j] = (int*)calloc(1025, sizeof(int));
        }
    }
    dp[0][0][grid[0][0]] = 1;

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            for (int k = 0; k < 1025; k++) {
                if (dp[i][j][k] > 0) {
                    if (i + 1 < n) {
                        dp[i + 1][j][k ^ grid[i + 1][j]] = (dp[i + 1][j][k ^ grid[i + 1][j]] + dp[i][j][k]) % mod;
                    }
                    if (j + 1 < m) {
                        dp[i][j + 1][k ^ grid[i][j + 1]] = (dp[i][j + 1][k ^ grid[i][j + 1]] + dp[i][j][k]) % mod;
                    }
                }
            }
        }
    }

    int result = 0;
    for (int i = 0; i < 1025; i++) {
        if (i == x) {
            for (int j = 0; j < n; j++) {
                for (int k = 0; k < m; k++) {
                    result = (result + dp[j][k][i]) % mod;
                }
            }
        }
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            free(dp[i][j]);
        }
        free(dp[i]);
    }
    free(dp);
    return result;
}