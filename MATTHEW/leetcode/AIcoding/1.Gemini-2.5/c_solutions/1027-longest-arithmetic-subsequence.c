#include <stdlib.h> // For malloc, free

#define MAX_NUM_VAL 500
#define MIN_NUM_VAL 0
#define MAX_DIFF (MAX_NUM_VAL - MIN_NUM_VAL)
#define MIN_DIFF (MIN_NUM_VAL - MAX_NUM_VAL)
#define DIFF_RANGE (MAX_DIFF - MIN_DIFF + 1)
#define DIFF_OFFSET (-MIN_DIFF) // This is 500, to map diff -500 to 0, 0 to 500, 500 to 1000

int longestArithmeticSubsequence(int* nums, int numsSize) {
    // Problem constraints state numsSize is between 2 and 1000.
    // So, numsSize >= 2.

    // dp[i][diff_offset] stores the length of the longest arithmetic subsequence
    // ending at index i with common difference (diff_offset - DIFF_OFFSET).
    // The difference 'diff' can range from -500 to 500.
    // We map this to an array index by adding DIFF_OFFSET (500).
    // So, diff_idx = diff + 500.
    int** dp = (int**)malloc(numsSize * sizeof(int*));
    for (int i = 0; i < numsSize; ++i) {
        dp[i] = (int*)malloc(DIFF_RANGE * sizeof(int));
        // Initialize all dp values to 1. Each element itself forms an arithmetic subsequence of length 1.
        // When we find a pair, the length becomes 1 (for current element) + 1 (for previous element) = 2.
        for (int k = 0; k < DIFF_RANGE; ++k) {
            dp[i][k] = 1;
        }
    }

    int max_len = 1; // Initialize max_len to 1. Since numsSize >= 2, it will be updated to at least 2.

    for (int i = 0; i < numsSize; ++i) {
        for (int j = 0; j < i; ++j) {
            int diff = nums[i] - nums[j];
            int diff_idx = diff + DIFF_OFFSET;

            // The length of the AS ending at nums[i] with this 'diff'
            // is 1 (for nums[i]) + the length of the AS ending at nums[j] with the same 'diff'.
            dp[i][diff_idx] = dp[j][diff_idx] + 1;

            if (dp[i][diff_idx] > max_len) {
                max_len = dp[i][diff_idx];
            }
        }
    }

    // Free allocated memory
    for (int i = 0; i < numsSize; ++i) {
        free(dp[i]);
    }
    free(dp);

    return max_len;
}