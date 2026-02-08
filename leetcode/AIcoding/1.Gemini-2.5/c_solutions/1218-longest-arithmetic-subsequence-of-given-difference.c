#include <stdlib.h> // For calloc, free
#include <string.h> // Not strictly needed for calloc, but often included with memory functions

int max(int a, int b) {
    return a > b ? a : b;
}

int longestSubsequence(int* arr, int arrSize, int difference) {
    // According to LeetCode constraints, arrSize >= 1.
    // If arrSize is 0, return 0.
    if (arrSize == 0) {
        return 0;
    }

    // The values in arr[i] and difference are in range [-10^4, 10^4].
    // A previous number in an arithmetic subsequence would be `current_num - difference`.
    // This `prev_num` can range from -10000 - 10000 = -20000 to 10000 - (-10000) = 20000.
    // To map these values to non-negative array indices, we use an offset.
    // Value `v` maps to index `v + OFFSET`.
    // Minimum value: -20000 -> index 0
    // Maximum value: 20000 -> index 40000
    const int OFFSET = 20000;
    const int DP_ARRAY_SIZE = 40001; // Size for indices 0 to 40000

    // Dynamically allocate memory for the DP table and initialize all elements to 0.
    // calloc is suitable as it initializes memory to zero, which is required for our DP logic.
    int* dp = (int*)calloc(DP_ARRAY_SIZE, sizeof(int));
    if (dp == NULL) {
        // Handle memory allocation failure.
        // In competitive programming, this is often ignored or handled by exiting.
        // For LeetCode, it's generally assumed allocations succeed within limits.
        return 0; 
    }

    int max_len = 0; // Initialize max_len to 0. It will be at least 1 for arrSize >= 1.

    for (int i = 0; i < arrSize; ++i) {
        int current_num = arr[i];
        int prev_num = current_num - difference;

        // Calculate the index for the current number in the dp array.
        // This index will always be within [0, DP_ARRAY_SIZE-1] because current_num is within [-10000, 10000].
        int current_idx = current_num + OFFSET;

        // Determine the length of the arithmetic subsequence ending with current_num.
        // Default length is 1 (the number itself).
        int len_ending_here = 1;

        // Check if `prev_num` is within the valid range that could have been stored in `dp`.
        // `prev_num` could be outside `[-10000, 10000]`, but its index `prev_num + OFFSET`
        // must be within `[0, DP_ARRAY_SIZE-1]`.
        // This check ensures we don't access `dp` out of bounds.
        int prev_idx = prev_num + OFFSET;
        if (prev_idx >= 0 && prev_idx < DP_ARRAY_SIZE) {
            // If `prev_num` was encountered before and its length is stored,
            // then `current_num` can extend that subsequence.
            len_ending_here = 1 + dp[prev_idx];
        }

        // Update the DP table: store the longest arithmetic subsequence ending with `current_num`.
        // If `current_num` appears multiple times, this will correctly update `dp[current_idx]`
        // to reflect the longest subsequence ending with that value based on all elements processed so far.
        dp[current_idx] = len_ending_here;

        // Update the overall maximum length found so far.
        max_len = max(max_len, len_ending_here);
    }

    // Free the dynamically allocated memory before returning.
    free(dp);

    return max_len;
}