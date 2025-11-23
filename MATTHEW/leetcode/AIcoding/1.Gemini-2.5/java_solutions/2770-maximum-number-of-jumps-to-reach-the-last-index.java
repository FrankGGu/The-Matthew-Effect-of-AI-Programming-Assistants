import java.util.Arrays;

class Solution {
    public int maximumJumps(int[] nums, int target) {
        int n = nums.length;
        int[] dp = new int[n];

        Arrays.fill(dp, -1); // Initialize all indices as unreachable
        dp[0] = 0; // Starting at index 0 requires 0 jumps

        for (int j = 1; j < n; j++) {
            for (int i = 0; i < j; i++) {
                // If index i is reachable and a jump from i to j is possible
                if (dp[i] != -1 && Math.abs(nums[i] - nums[j]) <= target) {
                    // Update dp[j] with the maximum number of jumps to reach j
                    dp[j] = Math.max(dp[j], dp[i] + 1);
                }
            }
        }

        return dp[n - 1]; // Return the maximum jumps to reach the last index
    }
}