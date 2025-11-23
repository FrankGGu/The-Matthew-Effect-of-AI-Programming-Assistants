class Solution {
    public long countIncreasingQuadruplets(int[] nums) {
        int n = nums.length;
        long ans = 0;

        // count_less[j_idx][val] stores the number of elements nums[x] such that x < j_idx and nums[x] < val.
        // j_idx ranges from 0 to n. val ranges from 1 to n+1.
        // The value dimension needs to go up to n+1 (inclusive) for comparisons, so size n+2.
        // The index dimension needs to go up to n (inclusive), so size n+1.
        int[][] count_less = new int[n + 1][n + 2];

        // Build count_less table
        // For each index j_idx (from 1 to n), we consider elements up to nums[j_idx-1].
        for (int j_idx = 1; j_idx <= n; j_idx++) {
            // Copy counts from previous index j_idx-1
            for (int val = 1; val <= n + 1; val++) {
                count_less[j_idx][val] = count_less[j_idx - 1][val];
            }
            // Increment counts for all values greater than nums[j_idx-1]
            // because nums[j_idx-1] is now available as an element for x < j_idx.
            for (int val = nums[j_idx - 1] + 1; val <= n + 1; val++) {
                count_less[j_idx][val]++;
            }
        }

        // count_greater[k_idx][val] stores the number of elements nums[x] such that x > k_idx and nums[x] > val.
        // k_idx ranges from 0 to n. val ranges from 1 to n+1.
        // The value dimension needs to go up to n+1 (inclusive) for comparisons, so size n+2.
        // The index dimension needs to go up to n (inclusive) to handle k_idx+1 when k_idx=n-1, so size n+1.
        int[][] count_greater = new int[n + 1][n + 2];

        // Build count_greater table
        // For each index k_idx (from n-1 down to 0), we consider elements from nums[k_idx+1].
        // The loop starts from n-2 because k_idx must be less than n-1 (l must be k_idx+1).
        // However, the table needs to be populated up to k_idx=n-1 to correctly calculate count_greater[n-2].
        // count_greater[n][val] will naturally be 0.
        for (int k_idx = n - 1; k_idx >= 0; k_idx--) {
            // Copy counts from next index k_idx+1
            for (int val = 1; val <= n + 1; val++) {
                count_greater[k_idx][val] = count_greater[k_idx + 1][val];
            }
            // Increment counts for all values smaller than nums[k_idx+1]
            // because nums[k_idx+1] is now available as an element for x > k_idx.
            for (int val = 1; val <= nums[k_idx] - 1; val++) { // Corrected: should be nums[k_idx] for current k_idx
                                                                // No, it should be nums[k_idx+1] as we are building based on elements *after* k_idx
                count_greater[k_idx][val]++;
            }
        }

        // Corrected build for count_greater:
        // Initialize count_greater[n][val] to 0, which is implicitly done by Java.
        // Iterate k_idx from n-2 down to 0.
        // For each k_idx, we are considering elements from nums[k_idx+1] onwards.
        // The loop should be:
        for (int k_idx = n - 2; k_idx >= 0; k_idx--) {
            for (int val = 1; val <= n + 1; val++) {
                count_greater[k_idx][val] = count_greater[k_idx + 1][val];
            }
            // Now, add the contribution of nums[k_idx + 1]
            for (int val = 1; val <= nums[k_idx + 1] - 1; val++) {
                count_greater[k_idx][val]++;
            }
        }

        // Iterate through all possible pairs (j, k) such that j < k
        // and nums[k] < nums[j] (this is the crucial condition for the middle two elements)
        // i < j < k < l
        for (int j = 0; j < n; j++) {
            for (int k = j + 1; k < n; k++) {
                if (nums[k] < nums[j]) {
                    // Count 'i': number of elements nums[x] such that x < j and nums[x] < nums[k]
                    // This is directly available from count_less[j][nums[k]]
                    long count_i = count_less[j][nums[k]];

                    // Count 'l': number of elements nums[x] such that x > k and nums[x] > nums[j]
                    // This is directly available from count_greater[k][nums[j]]
                    long count_l = count_greater[k][nums[j]];

                    ans += count_i * count_l;
                }
            }
        }

        return ans;
    }
}