class Solution {
    public long maximizeAmount(int amount, int[] conversions) {
        long[] dp = new long[amount + 1];
        for (int i = 1; i <= amount; i++) {
            dp[i] = i;
        }

        for (int conv : conversions) {
            for (int i = conv; i <= amount; i++) {
                dp[i] = Math.max(dp[i], dp[i - conv] + 1);
            }
        }

        return dp[amount];
    }
}