int cherryPickup(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize, n = gridColSize[0];
    int dp[m][n][n];

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            for (int k = 0; k < n; k++) {
                dp[i][j][k] = -1;
            }
        }
    }

    dp[0][0][n-1] = grid[0][0] + grid[0][n-1];

    for (int i = 1; i < m; i++) {
        for (int j = 0; j < n; j++) {
            for (int k = 0; k < n; k++) {
                int best = -1;
                for (int dj = -1; dj <= 1; dj++) {
                    for (int dk = -1; dk <= 1; dk++) {
                        int prev_j = j + dj;
                        int prev_k = k + dk;
                        if (prev_j >= 0 && prev_j < n && prev_k >= 0 && prev_k < n) {
                            if (dp[i-1][prev_j][prev_k] != -1) {
                                int current = dp[i-1][prev_j][prev_k];
                                if (j == k) {
                                    current += grid[i][j];
                                } else {
                                    current += grid[i][j] + grid[i][k];
                                }
                                if (current > best) {
                                    best = current;
                                }
                            }
                        }
                    }
                }
                dp[i][j][k] = best;
            }
        }
    }

    int result = 0;
    for (int j = 0; j < n; j++) {
        for (int k = 0; k < n; k++) {
            if (dp[m-1][j][k] > result) {
                result = dp[m-1][j][k];
            }
        }
    }

    return result;
}