class Solution {
    public int numberOfSets(int n, int k) {
        int MOD = 1000000007;
        int[][] dp = new int[n][k + 1];

        for (int i = 0; i < n; i++) {
            dp[i][0] = 1;
        }

        for (int j = 1; j <= k; j++) {
            for (int i = 1; i < n; i++) {
                dp[i][j] = (dp[i - 1][j] + dp[i - 1][j - 1]) % MOD;
                for (int x = 0; x < i; x++) {
                    dp[i][j] = (dp[i][j] + dp[x][j - 1]) % MOD;
                }
                dp[i][j] = (dp[i][j] - dp[i - 1][j - 1] + MOD) % MOD;
            }
        }

        return dp[n - 1][k];
    }
}