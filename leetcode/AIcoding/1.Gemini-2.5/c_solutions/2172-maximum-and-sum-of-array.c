#include <stdlib.h> // For malloc, free
#include <limits.h> // For INT_MIN

int max(int a, int b) {
    return a > b ? a : b;
}

int maximumANDSum(int* nums, int numsSize, int numSlots) {
    // max_mask will be 2^numsSize, representing all possible subsets of nums
    int max_mask = 1 << numsSize;

    // dp[mask] stores the maximum AND sum achievable using the numbers
    // represented by the set bits in 'mask'.
    int* dp = (int*)malloc(max_mask * sizeof(int));

    // Initialize dp array with INT_MIN to represent uncomputed or unreachable states.
    // Scores are non-negative, so 0 is a valid score.
    for (int i = 0; i < max_mask; ++i) {
        dp[i] = INT_MIN;
    }

    // Base case: No numbers placed (empty mask), sum is 0.
    dp[0] = 0;

    // Iterate through all possible masks (subsets of numbers)
    for (int mask = 0; mask < max_mask; ++mask) {
        // If the current mask is unreachable, skip it.
        if (dp[mask] == INT_MIN) {
            continue;
        }

        // k is the number of elements already placed (popcount of mask).
        // __builtin_popcount is a GCC extension for counting set bits, commonly supported on LeetCode.
        int k = __builtin_popcount(mask);

        // Determine the current slot index (1-based) where the (k+1)-th number will be placed.
        // If k is even, it's the first number in slot (k/2 + 1).
        // If k is odd, it's the second number in slot ((k-1)/2 + 1), which is also (k/2 + 1) using integer division.
        int current_slot_idx = (k / 2) + 1;

        // If the current slot index exceeds the total number of available slots,
        // we cannot place any more numbers for this path.
        // Given problem constraints (numsSize <= 2 * numSlots), this condition
        // will not be met for k < numsSize. It's kept for logical completeness.
        if (current_slot_idx > numSlots) {
            continue;
        }

        // Iterate over all numbers in nums
        for (int i = 0; i < numsSize; ++i) {
            // Check if nums[i] has not been placed yet (i.e., i-th bit is not set in mask)
            if (!((mask >> i) & 1)) {
                // Create a new mask by adding nums[i]
                int new_mask = mask | (1 << i);

                // Calculate the AND sum for nums[i] with the current slot
                int score_to_add = nums[i] & current_slot_idx;

                // Update dp[new_mask] with the maximum possible sum
                // (current sum from dp[mask] + score_to_add)
                dp[new_mask] = max(dp[new_mask], dp[mask] + score_to_add);
            }
        }
    }

    // The final answer is the maximum AND sum when all numbers have been placed.
    // This corresponds to the mask where all bits are set (1 << numsSize) - 1.
    int result = dp[max_mask - 1];

    // Free the dynamically allocated memory
    free(dp);

    return result;
}