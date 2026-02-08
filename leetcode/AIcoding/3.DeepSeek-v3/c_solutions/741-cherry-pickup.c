int cherryPickup(int** grid, int gridSize, int* gridColSize) {
    int n = gridSize;
    int dp[2 * n - 1][n][n];

    for (int t = 0; t < 2 * n - 1; t++) {
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                dp[t][i][j] = -1;
            }
        }
    }

    dp[0][0][0] = grid[0][0];

    for (int t = 1; t < 2 * n - 1; t++) {
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                int ci = t - i, cj = t - j;
                if (ci < 0 || ci >= n || cj < 0 || cj >= n) continue;
                if (grid[i][ci] == -1 || grid[j][cj] == -1) continue;

                int val = grid[i][ci];
                if (i != j || ci != cj) val += grid[j][cj];

                int best = -1;
                if (i > 0 && j > 0 && dp[t-1][i-1][j-1] != -1) 
                    best = fmax(best, dp[t-1][i-1][j-1] + val);
                if (i > 0 && dp[t-1][i-1][j] != -1) 
                    best = fmax(best, dp[t-1][i-1][j] + val);
                if (j > 0 && dp[t-1][i][j-1] != -1) 
                    best = fmax(best, dp[t-1][i][j-1] + val);
                if (dp[t-1][i][j] != -1) 
                    best = fmax(best, dp[t-1][i][j] + val);

                dp[t][i][j] = best;
            }
        }
    }

    return dp[2 * n - 2][n - 1][n - 1] == -1 ? 0 : dp[2 * n - 2][n - 1][n - 1];
}