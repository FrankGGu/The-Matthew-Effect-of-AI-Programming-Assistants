bool hasValidPath(char** grid, int gridSize, int* gridColSize) {
    int m = gridSize, n = gridColSize[0];
    if ((m + n - 1) % 2 != 0) return false;

    int maxLen = (m + n + 1) / 2;
    bool ***dp = (bool ***)malloc(m * sizeof(bool **));
    for (int i = 0; i < m; i++) {
        dp[i] = (bool **)malloc(n * sizeof(bool *));
        for (int j = 0; j < n; j++) {
            dp[i][j] = (bool *)calloc(maxLen + 1, sizeof(bool));
        }
    }

    if (grid[0][0] == '(') {
        dp[0][0][1] = true;
    } else {
        return false;
    }

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            for (int k = 0; k <= maxLen; k++) {
                if (dp[i][j][k]) {
                    if (i + 1 < m) {
                        if (grid[i+1][j] == '(') {
                            if (k + 1 <= maxLen) {
                                dp[i+1][j][k+1] = true;
                            }
                        } else {
                            if (k - 1 >= 0) {
                                dp[i+1][j][k-1] = true;
                            }
                        }
                    }
                    if (j + 1 < n) {
                        if (grid[i][j+1] == '(') {
                            if (k + 1 <= maxLen) {
                                dp[i][j+1][k+1] = true;
                            }
                        } else {
                            if (k - 1 >= 0) {
                                dp[i][j+1][k-1] = true;
                            }
                        }
                    }
                }
            }
        }
    }

    bool result = dp[m-1][n-1][0];

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            free(dp[i][j]);
        }
        free(dp[i]);
    }
    free(dp);

    return result;
}