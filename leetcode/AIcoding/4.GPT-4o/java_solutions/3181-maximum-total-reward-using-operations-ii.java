class Solution {
    public int maximumTotalReward(int[] rewards, int[][] operations) {
        int n = rewards.length;
        long[] dp = new long[n + 1];
        dp[0] = 0;

        for (int i = 1; i <= n; i++) {
            dp[i] = dp[i - 1] + rewards[i - 1];
        }

        for (int[] op : operations) {
            int l = op[0], r = op[1], x = op[2];
            for (int i = r; i >= l; i--) {
                dp[i] = Math.max(dp[i], dp[i - 1] + x);
            }
        }

        return (int) dp[n];
    }
}