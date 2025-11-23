class Solution {
    public int maxTotalScore(int[] nums, int k) {
        int n = nums.length;
        long[] dp = new long[n];
        dp[0] = nums[0];
        for (int i = 1; i < n; i++) {
            dp[i] = Long.MIN_VALUE;
            for (int j = Math.max(0, i - k); j < i; j++) {
                dp[i] = Math.max(dp[i], dp[j] + nums[i]);
            }
        }
        return (int) dp[n - 1];
    }
}