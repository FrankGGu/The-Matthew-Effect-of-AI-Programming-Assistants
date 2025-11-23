class Solution {
    public boolean isValidPartition(int[] nums) {
        int n = nums.length;
        boolean[] dp = new boolean[n + 1];

        // Base case: an empty prefix can be considered validly partitioned
        dp[0] = true; 

        for (int i = 1; i <= n; i++) {
            // Check for a 2-element partition ending at index i-1
            // Subarray: nums[i-2], nums[i-1]
            if (i >= 2) {
                if (nums[i-1] == nums[i-2]) {
                    dp[i] = dp[i] || dp[i-2];
                }
            }

            // Check for a 3-element partition ending at index i-1 (all equal)
            // Subarray: nums[i-3], nums[i-2], nums[i-1]
            if (i >= 3) {
                if (nums[i-1] == nums[i-2] && nums[i-2] == nums[i-3]) {
                    dp[i] = dp[i] || dp[i-3];
                }
            }

            // Check for a 3-element partition ending at index i-1 (consecutive increasing)
            // Subarray: nums[i-3], nums[i-2], nums[i-1]
            if (i >= 3) {
                if (nums[i-1] == nums[i-2] + 1 && nums[i-2] == nums[i-3] + 1) {
                    dp[i] = dp[i] || dp[i-3];
                }
            }
        }

        return dp[n];
    }
}