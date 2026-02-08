import java.util.Arrays;

class Solution {
    public long maximumProduct(int[] nums, int k) {
        int N = nums.length;

        // The maximum possible absolute sum for an alternating subsequence.
        // For N=50, max_val=50, min_val=1:
        // Max positive sum: (ceil(N/2) * 50) - (floor(N/2) * 1) = (25 * 50) - (25 * 1) = 1250 - 25 = 1225
        // Max negative sum: (ceil(N/2) * 1) - (floor(N/2) * 50) = (25 * 1) - (25 * 50) = 25 - 1250 = -1225
        // So, the alternating sum will always be within [-1225, 1225].
        int MAX_POSSIBLE_SUM_ABS = 1225;

        int OFFSET = MAX_POSSIBLE_SUM_ABS;
        int SUM_RANGE_SIZE = 2 * OFFSET + 1; // Range from -OFFSET to +OFFSET, inclusive.

        // If k is outside the maximum possible sum range, no such subsequence exists.
        if (k < -OFFSET || k > OFFSET) {
            return -1L;
        }

        // dp[i][current_sum_offset][last_op_state]
        // i: index in nums (0 to N) representing elements considered up to nums[i-1].
        // current_sum_offset: current_alternating_sum + OFFSET.
        // last_op_state:
        //   0: The last element included in the subsequence was ADDED (+X). So, the next element, if chosen, will be SUBTRACTED (-Y).
        //   1: The last element included in the subsequence was SUBTRACTED (-X). So, the next element, if chosen, will be ADDED (+Y).
        // Initialize with -1L to signify unreachable states or no subsequence found for that sum.
        long[][][] dp = new long[N + 1][SUM_RANGE_SIZE][2];
        for (int i = 0; i <= N; i++) {
            for (int j = 0; j < SUM_RANGE_SIZE; j++) {
                Arrays.fill(dp[i][j], -1L);
            }
        }

        // Base case: empty subsequence.
        // The sum is 0 (represented by OFFSET). The product is 1.
        // The first element of any non-empty subsequence is always added.
        // So, this state implies the *next* element (if chosen) will be added.
        dp[0][OFFSET][1] = 1L; 

        for (int i = 0; i < N; i++) {
            int val = nums[i];
            for (int s_idx = 0; s_idx < SUM_RANGE_SIZE; s_idx++) {
                for (int last_op_state = 0; last_op_state < 2; last_op_state++) {
                    if (dp[i][s_idx][last_op_state] == -1L) {
                        continue; // This state is unreachable, skip.
                    }

                    long current_product = dp[i][s_idx][last_op_state];
                    int current_sum = s_idx - OFFSET;

                    // Option 1: Don't include nums[i] in the subsequence.
                    // The sum, product, and the state for the next element remain the same.
                    // We take the maximum product for this state.
                    dp[i + 1][s_idx][last_op_state] = Math.max(dp[i + 1][s_idx][last_op_state], current_product);

                    // Option 2: Include nums[i] in the subsequence.
                    long new_product;
                    // Check for potential overflow before multiplication.
                    // If current_product * val would exceed Long.MAX_VALUE, cap it at Long.MAX_VALUE.
                    // This handles cases where the product becomes extremely large.
                    if (current_product > Long.MAX_VALUE / val) {
                        new_product = Long.MAX_VALUE;
                    } else {
                        new_product = current_product * val;
                    }

                    if (last_op_state == 1) { // Current state implies next element 'val' will be ADDED (+val).
                        int new_sum = current_sum + val;
                        int new_sum_idx = new_sum + OFFSET;
                        // Check if the new sum is within the valid range.
                        if (new_sum_idx >= 0 && new_sum_idx < SUM_RANGE_SIZE) {
                            // After adding 'val', the last operation was '+', so the next element will be SUBTRACTED.
                            dp[i + 1][new_sum_idx][0] = Math.max(dp[i + 1][new_sum_idx][0], new_product);
                        }
                    } else { // Current state implies next element 'val' will be SUBTRACTED (-val).
                        int new_sum = current_sum - val;
                        int new_sum_idx = new_sum + OFFSET;
                        // Check if the new sum is within the valid range.
                        if (new_sum_idx >= 0 && new_sum_idx < SUM_RANGE_SIZE) {
                            // After subtracting 'val', the last operation was '-', so the next element will be ADDED.
                            dp[i + 1][new_sum_idx][1] = Math.max(dp[i + 1][new_sum_idx][1], new_product);
                        }
                    }
                }
            }
        }

        long max_prod = -1L;
        int target_sum_idx = k + OFFSET;

        // After processing all elements, check the maximum product for the target sum 'k'.
        // We need to check both possible 'last_op_state' values, as the last element of the subsequence could have been added or subtracted.
        max_prod = Math.max(max_prod, dp[N][target_sum_idx][0]);
        max_prod = Math.max(max_prod, dp[N][target_sum_idx][1]);

        return max_prod;
    }
}