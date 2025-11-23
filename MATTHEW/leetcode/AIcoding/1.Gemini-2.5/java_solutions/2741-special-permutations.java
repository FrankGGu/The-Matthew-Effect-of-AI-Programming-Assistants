class Solution {
    public int specialPermutations(int[] nums) {
        int n = nums.length;
        int MOD = 1_000_000_007;

        // dp[mask][last_idx] stores the number of special permutations
        // using elements represented by 'mask', where the last element is nums[last_idx].
        // The mask is a bitmask where the i-th bit is set if nums[i] is included.
        long[][] dp = new long[1 << n][n];

        // Base cases: permutations of length 1.
        // Each single element forms a special permutation.
        for (int i = 0; i < n; i++) {
            dp[1 << i][i] = 1;
        }

        // Iterate through all possible masks from 1 to (2^n - 1)
        for (int mask = 1; mask < (1 << n); mask++) {
            // Iterate through the last element (its index) in the current permutation
            for (int last_idx = 0; last_idx < n; last_idx++) {
                // If nums[last_idx] is not part of the current mask, or if there are no
                // permutations ending with nums[last_idx] for this mask, skip.
                if (((mask >> last_idx) & 1) == 0 || dp[mask][last_idx] == 0) {
                    continue;
                }

                // Try to append a new element to the current permutation
                for (int next_idx = 0; next_idx < n; next_idx++) {
                    // If nums[next_idx] is already included in the current mask, skip.
                    if (((mask >> next_idx) & 1) != 0) {
                        continue;
                    }

                    // Check the special permutation condition:
                    // nums[last_idx] % nums[next_idx] == 0 OR nums[next_idx] % nums[last_idx] == 0
                    if (nums[last_idx] % nums[next_idx] == 0 || nums[next_idx] % nums[last_idx] == 0) {
                        int new_mask = mask | (1 << next_idx); // Add next_idx to the mask
                        dp[new_mask][next_idx] = (dp[new_mask][next_idx] + dp[mask][last_idx]) % MOD;
                    }
                }
            }
        }

        // After filling the DP table, sum up all permutations that use all elements.
        // The final mask will have all bits set: (1 << n) - 1.
        long totalSpecialPermutations = 0;
        int final_mask = (1 << n) - 1;
        for (int i = 0; i < n; i++) {
            totalSpecialPermutations = (totalSpecialPermutations + dp[final_mask][i]) % MOD;
        }

        return (int) totalSpecialPermutations;
    }
}