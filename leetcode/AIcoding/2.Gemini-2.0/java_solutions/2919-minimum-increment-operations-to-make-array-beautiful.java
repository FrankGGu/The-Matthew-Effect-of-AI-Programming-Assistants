class Solution {
    public long minIncrementOperations(int[] nums, int k) {
        int n = nums.length;
        long[] dp = new long[n + 1];
        dp[0] = 0;
        dp[1] = Math.max(0, k - nums[0]);
        if (n > 1) {
            dp[2] = Math.min(Math.max(0, k - nums[0]) + Math.max(0, k - nums[1]),
                    Math.max(0, k - nums[1]) + Math.max(0, k - nums[0]));
        }

        for (int i = 3; i <= n; i++) {
            dp[i] = Math.min(dp[i - 1] + Math.max(0, k - nums[i - 1]),
                    Math.min(dp[i - 2] + Math.max(0, k - nums[i - 2]),
                            dp[i - 3] + Math.max(0, k - nums[i - 3])));
        }

        return dp[n];
    }
}