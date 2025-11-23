import java.util.Arrays;

class Solution {
    public long maximumTotalReward(int[] rewards, int k) {
        int n = rewards.length;
        long[] dp = new long[n + 1];
        Arrays.fill(dp, 0);

        for (int i = 1; i <= n; i++) {
            dp[i] = dp[i - 1];
            if (i >= k) {
                long sum = 0;
                for (int j = i - k; j < i; j++) {
                    sum += rewards[j];
                }
                dp[i] = Math.max(dp[i], dp[i - k] + 2 * sum);
            }
            dp[i] = Math.max(dp[i], dp[i-1] + rewards[i-1]);
        }

        return dp[n];
    }
}