int findPaths(int m, int n, int maxMove, int startRow, int startColumn) {
    const int MOD = 1000000007;
    int dp[51][51][51] = {0};
    int directions[4][2] = {{0,1}, {0,-1}, {1,0}, {-1,0}};

    for (int move = 1; move <= maxMove; move++) {
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                for (int d = 0; d < 4; d++) {
                    int ni = i + directions[d][0];
                    int nj = j + directions[d][1];
                    if (ni < 0 || ni >= m || nj < 0 || nj >= n) {
                        dp[move][i][j] = (dp[move][i][j] + 1) % MOD;
                    } else {
                        dp[move][i][j] = (dp[move][i][j] + dp[move-1][ni][nj]) % MOD;
                    }
                }
            }
        }
    }

    return dp[maxMove][startRow][startColumn];
}