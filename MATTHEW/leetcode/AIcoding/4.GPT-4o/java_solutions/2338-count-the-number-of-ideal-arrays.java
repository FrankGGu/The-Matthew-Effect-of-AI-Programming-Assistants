class Solution {
    public int idealArrays(int n, int maxValue) {
        final int MOD = 1000000007;
        long[][] dp = new long[maxValue + 1][n + 1];
        long[] sum = new long[n + 1];

        for (int i = 1; i <= maxValue; i++) {
            dp[i][1] = 1;
            sum[1] = (sum[1] + dp[i][1]) % MOD;
        }

        for (int len = 2; len <= n; len++) {
            for (int i = 1; i <= maxValue; i++) {
                for (int j = i; j <= maxValue; j += i) {
                    dp[j][len] = (dp[j][len] + dp[i][len - 1]) % MOD;
                }
                sum[len] = (sum[len] + dp[i][len]) % MOD;
            }
        }

        return (int) sum[n];
    }
}