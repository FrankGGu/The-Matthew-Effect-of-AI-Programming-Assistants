class Solution {
    public int peopleAwareOfSecret(int n, int delay, int forget) {
        int MOD = 1000000007;
        long[] dp = new long[n + 1];
        dp[1] = 1;
        long share = 0;
        for (int i = 2; i <= n; i++) {
            if (i - delay >= 1) {
                share = (share + dp[i - delay]) % MOD;
            }
            if (i - forget >= 1) {
                share = (share - dp[i - forget] + MOD) % MOD;
            }
            dp[i] = share;
        }
        long res = 0;
        for (int i = n - forget + 1; i <= n; i++) {
            res = (res + dp[i]) % MOD;
        }
        return (int) res;
    }
}