class Solution {
    private static final int MOD = 1000000007;

    public int checkRecord(int n) {
        long[] dp = new long[n <= 5 ? 6 : n + 1];
        dp[0] = 1;
        dp[1] = 2;
        dp[2] = 4;
        dp[3] = 7;
        for (int i = 4; i <= n; i++) {
            dp[i] = (2 * dp[i - 1] - dp[i - 4]) % MOD;
            if (dp[i] < 0) dp[i] += MOD;
        }
        long sum = dp[n];
        for (int i = 1; i <= n; i++) {
            sum += (dp[i - 1] * dp[n - i]) % MOD;
            sum %= MOD;
        }
        return (int) sum;
    }
}