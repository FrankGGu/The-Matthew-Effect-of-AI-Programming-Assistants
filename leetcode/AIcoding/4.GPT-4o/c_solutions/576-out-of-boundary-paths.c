int findPaths(int m, int n, int maxMove, int startRow, int startColumn) {
    int mod = 1e9 + 7;
    long dp[51][51][51] = {0};
    dp[startRow][startColumn][0] = 1;
    long result = 0;

    for (int moves = 1; moves <= maxMove; moves++) {
        for (int r = 0; r < m; r++) {
            for (int c = 0; c < n; c++) {
                dp[r][c][moves] = (dp[r - 1][c][moves - 1] + dp[r + 1][c][moves - 1] +
                                   dp[r][c - 1][moves - 1] + dp[r][c + 1][moves - 1]) % mod;
                if (r == 0) result = (result + dp[r][c][moves - 1]) % mod;
                if (r == m - 1) result = (result + dp[r][c][moves - 1]) % mod;
                if (c == 0) result = (result + dp[r][c][moves - 1]) % mod;
                if (c == n - 1) result = (result + dp[r][c][moves - 1]) % mod;
            }
        }
    }

    return result;
}