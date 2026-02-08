class Solution {
    public int numberOfWinningSequences(int num, int lower, int upper) {
        int total = upper - lower + 1;
        if (num == 1) {
            return total;
        }
        long mod = (long)1e9 + 7;
        long[] dp = new long[num + 1];
        dp[0] = 1;
        for (int i = 1; i <= num; i++) {
            dp[i] = (dp[i - 1] * total) % mod;
        }
        long res = (dp[num] - 2 * dp[num - 1] + (num >= 2 ? dp[num - 2] : 0)) % mod;
        if (res < 0) {
            res += mod;
        }
        return (int)res;
    }
}