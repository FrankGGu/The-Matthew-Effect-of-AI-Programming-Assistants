class Solution {
    private static final int MOD = 1000000007;

    public int findPaths(int m, int n, int maxMove, int startRow, int startColumn) {
        int[][][] dp = new int[maxMove + 1][m][n];
        for (int moves = 1; moves <= maxMove; moves++) {
            for (int i = 0; i < m; i++) {
                for (int j = 0; j < n; j++) {
                    if (i == 0) dp[moves][i][j] = (dp[moves][i][j] + 1) % MOD;
                    if (i == m - 1) dp[moves][i][j] = (dp[moves][i][j] + 1) % MOD;
                    if (j == 0) dp[moves][i][j] = (dp[moves][i][j] + 1) % MOD;
                    if (j == n - 1) dp[moves][i][j] = (dp[moves][i][j] + 1) % MOD;

                    if (i > 0) dp[moves][i][j] = (dp[moves][i][j] + dp[moves - 1][i - 1][j]) % MOD;
                    if (i < m - 1) dp[moves][i][j] = (dp[moves][i][j] + dp[moves - 1][i + 1][j]) % MOD;
                    if (j > 0) dp[moves][i][j] = (dp[moves][i][j] + dp[moves - 1][i][j - 1]) % MOD;
                    if (j < n - 1) dp[moves][i][j] = (dp[moves][i][j] + dp[moves - 1][i][j + 1]) % MOD;
                }
            }
        }
        return dp[maxMove][startRow][startColumn];
    }
}