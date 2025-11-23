#include <limits.h> // For INT_MAX

static int max(int a, int b) {
    return a > b ? a : b;
}

static int min(int a, int b) {
    return a < b ? a : b;
}

int minSpaceWastedKResizing(int* nums, int numsSize, int k) {
    // dp[i][j] will store the minimum waste for the first 'i' elements using 'j' resizing operations.
    // 'i' goes from 0 to numsSize.
    // 'j' goes from 0 to k.
    int dp[numsSize + 1][k + 1];

    // Initialize dp table with a large value (infinity)
    for (int i = 0; i <= numsSize; i++) {
        for (int j = 0; j <= k; j++) {
            dp[i][j] = INT_MAX;
        }
    }

    // Base case: 0 elements, 0 operations, 0 waste.
    dp[0][0] = 0;

    // Fill dp[i][0] for all i (0 operations means 1 block for nums[0...i-1])
    // This block covers all elements from index 0 to i-1.
    int current_max_val_for_one_block = 0;
    int current_sum_val_for_one_block = 0;
    for (int i = 1; i <= numsSize; i++) {
        current_max_val_for_one_block = max(current_max_val_for_one_block, nums[i - 1]);
        current_sum_val_for_one_block += nums[i - 1];
        dp[i][0] = (current_max_val_for_one_block * i) - current_sum_val_for_one_block;
    }

    // Fill dp table for j > 0 operations
    for (int j = 1; j <= k; j++) { // Number of resizing operations
        for (int i = 1; i <= numsSize; i++) { // Number of elements considered
            // Optimization: If we have enough operations to make each element its own block,
            // the waste is 0. 'j' operations mean 'j+1' blocks.
            // If 'j+1' blocks are sufficient for 'i' elements (i.e., j+1 >= i), then waste is 0.
            if (j + 1 >= i) {
                dp[i][j] = 0;
                continue;
            }

            int current_max_segment = 0;
            int current_sum_segment = 0;
            // Iterate 'p' from 'i-1' down to '0'.
            // 'p' is the starting index of the *last* block: nums[p...i-1].
            // The prefix nums[0...p-1] is covered by 'j-1' operations.
            for (int p = i - 1; p >= 0; p--) {
                current_max_segment = max(current_max_segment, nums[p]);
                current_sum_segment += nums[p];
                int segment_len = i - p;
                int waste_segment = (current_max_segment * segment_len) - current_sum_segment;

                // Check if the previous state dp[p][j-1] is reachable (not INT_MAX)
                // dp[p][j-1] represents the minimum waste for 'p' elements using 'j-1' operations.
                if (dp[p][j-1] != INT_MAX) {
                    dp[i][j] = min(dp[i][j], dp[p][j-1] + waste_segment);
                }
            }
        }
    }

    return dp[numsSize][k];
}