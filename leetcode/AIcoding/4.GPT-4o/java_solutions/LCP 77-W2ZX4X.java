class Solution {
    public long computePower(long n, long m) {
        long result = 1;
        for (long i = 0; i < m; i++) {
            result = (result * n) % 1000000007;
        }
        return result;
    }

    public long[] runeReserve(int[] runes, int n) {
        long[] dp = new long[n + 1];
        dp[0] = 1;
        for (int rune : runes) {
            for (int j = rune; j <= n; j++) {
                dp[j] = (dp[j] + dp[j - rune]) % 1000000007;
            }
        }
        return dp;
    }
}