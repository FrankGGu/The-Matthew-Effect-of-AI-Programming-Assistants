class Solution {
    public int numTilings(int N) {
        if (N == 0) return 1;
        if (N == 1) return 1;
        if (N == 2) return 2;

        int MOD = 1000000007;
        long[] dp = new long[N + 1];
        dp[0] = 1;
        dp[1] = 1;
        dp[2] = 2;

        for (int i = 3; i <= N; i++) {
            dp[i] = (dp[i - 1] + dp[i - 2] * 2) % MOD;
        }

        return (int) dp[N];
    }
}