class Solution {
    public boolean canSplitArray(int[] nums, int m) {
        int n = nums.length;

        // If the array has only one element, no splits are performed.
        // The condition "for every split operation on an array arr..." is vacuously true
        // because there are no split operations. Thus, it's always possible.
        if (n == 1) {
            return true;
        }

        // Precompute prefix sums to calculate subarray sums in O(1) time.
        // prefixSum[i] stores the sum of elements from nums[0] to nums[i-1].
        // So, sum of nums[x...y] = prefixSum[y+1] - prefixSum[x].
        long[] prefixSum = new long[n + 1];
        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = prefixSum[i] + nums[i];
        }

        // dp[i][j] will be true if the subarray nums[i...j] can be split
        // according to the given rules, and false otherwise.
        boolean[][] dp = new boolean[n][n];

        // Base case: A subarray of length 1 (e.g., nums[i...i]) is already fully split.
        // No further splits are needed, so the condition "for every split operation" is
        // vacuously true. Thus, all single-element subarrays are considered splittable.
        for (int i = 0; i < n; i++) {
            dp[i][i] = true;
        }

        // Fill the DP table for subarrays of increasing length.
        // 'len' represents the current length of the subarray being considered.
        for (int len = 2; len <= n; len++) {
            // 'i' is the starting index of the current subarray.
            for (int i = 0; i <= n - len; i++) {
                // 'j' is the ending index of the current subarray.
                int j = i + len - 1;

                // Try all possible split points 'k' for the subarray nums[i...j].
                // A split at 'k' divides nums[i...j] into nums[i...k] (left)
                // and nums[k+1...j] (right).
                for (int k = i; k < j; k++) {
                    long leftSum = prefixSum[k + 1] - prefixSum[i];
                    long rightSum = prefixSum[j + 1] - prefixSum[k + 1];

                    // For the current split to be valid:
                    // 1. The sum of the left subarray (nums[i...k]) must be >= m.
                    // 2. The sum of the right subarray (nums[k+1...j]) must be >= m.
                    // 3. Both the left subarray (nums[i...k]) and the right subarray (nums[k+1...j])
                    //    must themselves be splittable according to the rules (checked by dp[i][k] and dp[k+1][j]).
                    if (leftSum >= m && rightSum >= m && dp[i][k] && dp[k + 1][j]) {
                        dp[i][j] = true;
                        break; // If we found one valid way to split nums[i...j], we can stop checking other 'k' values.
                    }
                }
            }
        }

        // The final answer is whether the entire array nums[0...n-1] can be split.
        return dp[0][n - 1];
    }
}