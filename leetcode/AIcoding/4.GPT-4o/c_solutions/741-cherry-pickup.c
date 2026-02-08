int cherryPickup(int** grid, int gridSize, int* gridColSize) {
    int n = gridSize;
    int m = gridColSize[0];
    int dp[n][m][m];
    memset(dp, -1, sizeof(dp));
    dp[0][0][0] = grid[0][0];

    for (int r = 0; r < n; r++) {
        for (int c1 = 0; c1 < m; c1++) {
            for (int c2 = 0; c2 < m; c2++) {
                if (dp[r][c1][c2] < 0) continue;
                if (r + 1 < n) {
                    for (int nc1 = c1 - 1; nc1 <= c1 + 1; nc1++) {
                        for (int nc2 = c2 - 1; nc2 <= c2 + 1; nc2++) {
                            if (nc1 >= 0 && nc1 < m && nc2 >= 0 && nc2 < m) {
                                dp[r + 1][nc1][nc2] = fmax(dp[r + 1][nc1][nc2], dp[r][c1][c2] + (c1 == c2 ? grid[r + 1][nc1] : grid[r + 1][nc1] + grid[r + 1][nc2]));
                            }
                        }
                    }
                }
            }
        }
    }

    return fmax(0, dp[n - 1][m - 1][m - 1]);
}