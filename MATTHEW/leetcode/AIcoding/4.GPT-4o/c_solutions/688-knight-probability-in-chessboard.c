double knightProbability(int n, int k, int row, int column) {
    double dp[n][n][k + 1];
    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++)
            dp[i][j][0] = 1.0;

    int directions[8][2] = {{-2, -1}, {-1, -2}, {1, -2}, {2, -1}, 
                            {2, 1}, {1, 2}, {-1, 2}, {-2, 1}};

    for (int step = 1; step <= k; step++) {
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                dp[i][j][step] = 0.0;
                for (int d = 0; d < 8; d++) {
                    int ni = i + directions[d][0];
                    int nj = j + directions[d][1];
                    if (ni >= 0 && ni < n && nj >= 0 && nj < n) {
                        dp[i][j][step] += dp[ni][nj][step - 1] / 8.0;
                    }
                }
            }
        }
    }
    return dp[row][column][k];
}