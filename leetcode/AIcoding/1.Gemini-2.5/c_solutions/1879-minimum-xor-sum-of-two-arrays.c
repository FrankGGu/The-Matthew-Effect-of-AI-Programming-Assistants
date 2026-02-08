#include <limits.h>
#include <stdlib.h>

int minimumXORSum(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    int n = nums1Size;
    int max_mask = 1 << n;

    // dp[mask] stores the minimum XOR sum using the first 'count' elements of nums1
    // (where 'count' is the number of set bits in 'mask')
    // and the elements of nums2 whose indices are set in 'mask'.
    int* dp = (int*)malloc(sizeof(int) * max_mask);

    for (int i = 0; i < max_mask; ++i) {
        dp[i] = INT_MAX;
    }

    // Base case: no elements used, sum is 0
    dp[0] = 0;

    // Iterate through all possible masks
    for (int mask = 0; mask < max_mask; ++mask) {
        // If this state is unreachable, skip it
        if (dp[mask] == INT_MAX) {
            continue;
        }

        // 'i' is the index of the current element in nums1 we are trying to assign.
        // It's equal to the number of elements from nums2 already used (popcount of mask).
        int i = __builtin_popcount(mask);

        // If all elements of nums1 have been assigned, we don't need to process this mask further
        // for extending to new masks, as it's a complete state.
        if (i == n) {
            continue;
        }

        // Try to assign nums1[i] to an unused element nums2[j]
        for (int j = 0; j < n; ++j) {
            // Check if nums2[j] has not been used yet (j-th bit is not set in mask)
            if (!((mask >> j) & 1)) {
                int new_mask = mask | (1 << j);
                int current_xor_sum = dp[mask] + (nums1[i] ^ nums2[j]);
                if (current_xor_sum < dp[new_mask]) {
                    dp[new_mask] = current_xor_sum;
                }
            }
        }
    }

    int result = dp[max_mask - 1]; // The minimum XOR sum for all elements assigned

    free(dp);

    return result;
}