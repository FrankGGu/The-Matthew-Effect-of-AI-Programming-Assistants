class Solution {
    public int countBalancedPermutations(int n) {
        if (n == 1) return 1;
        int MOD = 1000000007;
        long[] dp = new long[n + 1];
        dp[1] = 1;
        dp[2] = 2;
        for (int i = 3; i <= n; i++) {
            dp[i] = (dp[i - 1] + dp[i - 2]) % MOD;
        }
        return (int) ((dp[n] * 2) % MOD);
    }
}