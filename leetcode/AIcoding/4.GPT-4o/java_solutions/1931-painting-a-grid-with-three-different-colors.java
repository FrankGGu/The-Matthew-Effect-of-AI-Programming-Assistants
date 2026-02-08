class Solution {
    public int paintingPlan(int m, int n, int k) {
        int MOD = 1000000007;
        long[][] dp = new long[k + 1][m + 1];
        dp[0][0] = 1;

        for (int i = 1; i <= k; i++) {
            for (int j = 1; j <= m; j++) {
                dp[i][j] = (dp[i][j - 1] * 3) % MOD;
                if (j > 1) {
                    dp[i][j] = (dp[i][j] + (dp[i - 1][j - 1] * 2) % MOD) % MOD;
                }
            }
        }

        long result = 1;
        for (int i = 0; i < n; i++) {
            result = (result * dp[k][m]) % MOD;
        }

        return (int) result;
    }
}