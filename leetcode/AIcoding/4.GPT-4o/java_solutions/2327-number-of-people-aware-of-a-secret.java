class Solution {
    public int peopleAwareOfSecret(int n, int delay, int forget) {
        long[] dp = new long[n + 1];
        dp[1] = 1;
        long mod = 1000000007;
        long res = 0;

        for (int i = 1; i <= n; i++) {
            if (i >= delay) {
                dp[i] = (dp[i] + dp[i - delay]) % mod;
            }
            if (i >= forget) {
                dp[i] = (dp[i] - dp[i - forget] + mod) % mod;
            }
            if (i < n) {
                dp[i + 1] = (dp[i + 1] + dp[i]) % mod;
            }
            if (i >= delay) {
                res = (res + dp[i]) % mod;
            }
        }

        return (int) res;
    }
}