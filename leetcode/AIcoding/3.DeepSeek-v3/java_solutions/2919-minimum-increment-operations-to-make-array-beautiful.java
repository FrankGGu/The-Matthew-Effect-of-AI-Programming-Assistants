class Solution {
    public int minIncrementOperations(int[] nums, int k) {
        int n = nums.length;
        long[] dp = new long[n];
        for (int i = 0; i < n; i++) {
            long increment = Math.max(0, k - nums[i]);
            if (i < 3) {
                dp[i] = increment;
            } else {
                dp[i] = increment + Math.min(dp[i - 1], Math.min(dp[i - 2], dp[i - 3]));
            }
        }
        if (n < 3) return 0;
        return (int) Math.min(dp[n - 1], Math.min(dp[n - 2], dp[n - 3]));
    }
}