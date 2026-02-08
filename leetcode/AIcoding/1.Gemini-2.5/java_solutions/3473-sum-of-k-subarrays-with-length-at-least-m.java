class Solution {
    public long sumOfKSubarraysWithLengthAtLeastM(int[] nums, int k, int m) {
        int n = nums.length;

        // prefixSum[i] stores the sum of nums[0...i-1]
        // prefixSum[0] = 0
        // prefixSum[i] = nums[0] + ... + nums[i-1]
        long[] prefixSum = new long[n + 1];
        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = prefixSum[i] + nums[i];
        }

        // dp[i][j] represents the maximum sum of 'j' non-overlapping subarrays
        // using elements from nums[0...i-1], where each subarray has length at least 'm'.
        // Initialize with a very small value to represent impossible states.
        long[][] dp = new long[n + 1][k + 1];
        for (int i = 0; i <= n; i++) {
            for (int j = 1; j <= k; j++) {
                dp[i][j] = Long.MIN_VALUE;
            }
        }
        // dp[i][0] = 0 for all i, as the sum of 0 subarrays is 0.

        for (int j = 1; j <= k; j++) {
            // max_val_for_prev_stage stores max(dp[p][j-1] - prefixSum[p]) for p up to current_p_candidate
            // This helps optimize the inner loop from O(N) to O(1).
            long max_val_for_prev_stage = Long.MIN_VALUE;

            for (int i = 1; i <= n; i++) {
                // Option 1: The j-th subarray does not end at index i-1.
                // In this case, the maximum sum is the same as considering elements up to i-2.
                dp[i][j] = dp[i - 1][j];

                // Check if it's possible to form a subarray of length 'm' ending at index i-1.
                // This means the subarray starts at index (i-m) or earlier.
                // The previous j-1 subarrays must have used elements up to index (i-m-1).
                // So, we consider dp[i-m][j-1] for the previous stage.
                if (i >= m) {
                    int p_candidate = i - m; // This is the index for dp and prefixSum for the previous stage.

                    // Update max_val_for_prev_stage with the current candidate for p_candidate.
                    // We only consider it if dp[p_candidate][j-1] is a valid (not MIN_VALUE) state.
                    if (dp[p_candidate][j - 1] != Long.MIN_VALUE) {
                        max_val_for_prev_stage = Math.max(max_val_for_prev_stage, dp[p_candidate][j - 1] - prefixSum[p_candidate]);
                    }

                    // Option 2: The j-th subarray ends at index i-1.
                    // Its sum is prefixSum[i] - prefixSum[p_start], where p_start is its starting index.
                    // The previous j-1 subarrays must have ended before p_start.
                    // We need to add the sum of the current subarray (prefixSum[i] - prefixSum[p_start])
                    // to the max sum of j-1 subarrays ending before p_start (dp[p_start][j-1]).
                    // This is equivalent to max_val_for_prev_stage + prefixSum[i].
                    if (max_val_for_prev_stage != Long.MIN_VALUE) {
                        dp[i][j] = Math.max(dp[i][j], max_val_for_prev_stage + prefixSum[i]);
                    }
                }
            }
        }

        // The final answer is the maximum sum of 'k' subarrays using all 'n' elements.
        // If dp[n][k] is still Long.MIN_VALUE, it means no such combination of subarrays could be formed.
        // Since nums[i] are positive, any valid sum will be positive.
        // Returning 0 for no solution is a common practice if positive sums are expected.
        // However, returning dp[n][k] directly allows the caller to distinguish between 0 sum and no solution.
        // For this problem, it's safer to return 0 if no solution found, assuming problem implies non-negative result.
        return Math.max(0, dp[n][k]);
    }
}