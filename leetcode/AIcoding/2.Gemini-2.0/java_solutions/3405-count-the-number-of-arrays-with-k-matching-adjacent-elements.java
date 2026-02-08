class Solution {
    private static final int MOD = 1000000007;

    public int countArrays(int n, int k) {
        if (k == 0) {
            return 0;
        }

        long[][] dp = new long[n][k + 1];
        dp[0][1] = 1;

        for (int i = 1; i < n; i++) {
            long sum = 0;
            for (int j = 1; j <= k; j++) {
                sum = (sum + dp[i - 1][j]) % MOD;
            }

            for (int j = 1; j <= k; j++) {
                dp[i][j] = (sum - dp[i - 1][j] + MOD) % MOD;
                if (j > 1) {
                    dp[i][j] = (dp[i][j] + dp[i - 1][j - 1]) % MOD;
                } else {
                     dp[i][j] = (dp[i][j]) % MOD;
                }
            }
        }

        long ans = 0;
        for (int j = 1; j <= k; j++) {
            ans = (ans + dp[n - 1][j]) % MOD;
        }

        return (int) ans;
    }
}