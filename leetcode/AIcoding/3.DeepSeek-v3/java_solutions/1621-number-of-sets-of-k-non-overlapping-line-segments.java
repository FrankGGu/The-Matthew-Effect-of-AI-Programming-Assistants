class Solution {
    public int numberOfSets(int n, int k) {
        int MOD = 1000000007;
        int[][] dp = new int[n + 1][k + 1];
        for (int i = 0; i <= n; i++) {
            dp[i][0] = 1;
        }
        for (int i = 2; i <= n; i++) {
            for (int j = 1; j <= k; j++) {
                dp[i][j] = (dp[i - 1][j] + dp[i - 1][j - 1]) % MOD;
                if (i > 2) {
                    dp[i][j] = (dp[i][j] + dp[i - 1][j]) % MOD;
                    dp[i][j] = (dp[i][j] - dp[i - 2][j] + MOD) % MOD;
                }
            }
        }
        return dp[n][k];
    }
}