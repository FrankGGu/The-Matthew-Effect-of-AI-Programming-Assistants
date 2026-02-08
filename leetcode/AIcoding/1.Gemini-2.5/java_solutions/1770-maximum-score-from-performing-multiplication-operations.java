import java.util.Arrays;

class Solution {
    public long maximumScore(int[] nums, int[] multipliers) {
        int n = nums.length;
        int m = multipliers.length;

        // dp[j] will store the maximum score after 'i-1' operations, having taken 'j' elements from the left.
        // We use two arrays for space optimization: 'dp' for i-1 operations, 'next_dp' for i operations.
        long[] dp = new long[m + 1]; 
        Arrays.fill(dp, Long.MIN_VALUE);
        dp[0] = 0; // Base case: 0 operations, 0 elements from left, score is 0.

        // Loop through each multiplier (each operation)
        for (int i = 1; i <= m; i++) {
            long[] next_dp = new long[m + 1]; // For current 'i' operations
            Arrays.fill(next_dp, Long.MIN_VALUE); // Initialize with negative infinity

            int current_multiplier = multipliers[i - 1];

            // 'left' is the number of elements taken from the left side of 'nums'.
            // 'left' can range from 0 to 'i' (inclusive).
            for (int left = 0; left <= i; left++) {
                long scoreFromLeft = Long.MIN_VALUE;
                // Option 1: The current operation takes an element from the left end.
                // This means in the previous step (i-1 operations), 'left-1' elements were taken from the left.
                // The element taken now is nums[left-1].
                if (left > 0 && dp[left - 1] != Long.MIN_VALUE) {
                    scoreFromLeft = dp[left - 1] + (long)nums[left - 1] * current_multiplier;
                }

                long scoreFromRight = Long.MIN_VALUE;
                // Option 2: The current operation takes an element from the right end.
                // This means in the previous step (i-1 operations), 'left' elements were taken from the left.
                // The total elements taken so far is 'i'. If 'left' are from left, then 'i - left' are from right.
                // The index of the rightmost element to be taken from 'nums' is n - (number of elements taken from right).
                int rightCount = i - left;
                // Check if the previous state (dp[left]) was reachable.
                if (dp[left] != Long.MIN_VALUE) {
                    int right_idx = n - rightCount; 
                    scoreFromRight = dp[left] + (long)nums[right_idx] * current_multiplier;
                }

                next_dp[left] = Math.max(scoreFromLeft, scoreFromRight);
            }
            dp = next_dp; // Update dp to be the current_dp for the next iteration
        }

        // After 'm' operations, find the maximum score among all possible 'left' counts.
        long maxScore = Long.MIN_VALUE;
        for (long score : dp) {
            maxScore = Math.max(maxScore, score);
        }

        return maxScore;
    }
}