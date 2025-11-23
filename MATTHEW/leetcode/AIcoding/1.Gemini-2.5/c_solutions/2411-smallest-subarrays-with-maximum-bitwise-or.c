#include <stdlib.h> // For malloc, free
#include <string.h> // For memset

static int max(int a, int b) {
    return a > b ? a : b;
}

int* smallestSubarrays(int* nums, int numsSize, int* returnSize) {
    *returnSize = numsSize;
    int* ans = (int*)malloc(numsSize * sizeof(int));
    if (ans == NULL) {
        return NULL; // Handle memory allocation failure
    }

    if (numsSize == 0) {
        return ans;
    }

    // max_or_suffix[i] will store the bitwise OR of all elements from nums[i] to nums[numsSize-1].
    // This represents the maximum possible bitwise OR for any subarray starting at index i.
    int* max_or_suffix = (int*)malloc(numsSize * sizeof(int));
    if (max_or_suffix == NULL) {
        free(ans);
        return NULL; // Handle memory allocation failure
    }

    // Precompute max_or_suffix array from right to left
    max_or_suffix[numsSize - 1] = nums[numsSize - 1];
    for (int i = numsSize - 2; i >= 0; --i) {
        max_or_suffix[i] = nums[i] | max_or_suffix[i + 1];
    }

    // last_seen_idx[bit] stores the index of the rightmost occurrence of 'bit'
    // in the suffix nums[i+1...numsSize-1] when processing index i.
    // Initialize with -1, indicating no occurrence yet for any bit.
    int last_seen_idx[31]; // Max value of nums[k] is 10^9, which is less than 2^30.
                           // So, bits 0 through 29 are relevant. Array size 31 covers these.
    memset(last_seen_idx, -1, sizeof(last_seen_idx));

    // Iterate from right to left to populate the answer array
    for (int i = numsSize - 1; i >= 0; --i) {
        int current_max_j = i; // The smallest possible 'j' for a subarray starting at 'i' is 'i' itself.
                               // This will be updated to ensure all required bits are covered.
        int target_or = max_or_suffix[i]; // The maximum possible OR value for subarrays starting at 'i'.

        // For each bit (0 to 30)
        for (int bit = 0; bit < 31; ++bit) {
            // If this bit is set in the target_or, it means we need this bit to be set
            // in our subarray's OR sum.
            if ((target_or >> bit) & 1) {
                // Determine the effective rightmost position for this bit.
                // If nums[i] itself has this bit set, then 'i' is the current rightmost position
                // for this bit within the context of the current index 'i'.
                // Otherwise, we rely on the 'last_seen_idx[bit]' which holds the rightmost
                // position of this bit in nums[i+1...numsSize-1].
                int effective_last_pos_for_bit = ((nums[i] >> bit) & 1) ? i : last_seen_idx[bit];

                // The 'j' for the current 'i' must be at least this effective_last_pos_for_bit
                // to ensure this bit is covered. We take the maximum across all required bits.
                current_max_j = max(current_max_j, effective_last_pos_for_bit);
            }
        }
        // The length of the smallest subarray is (current_max_j - i + 1)
        ans[i] = current_max_j - i + 1;

        // Update last_seen_idx for nums[i] for the next iteration (i-1)
        // This means for any bit set in nums[i], 'i' is now its rightmost occurrence
        // when considering indices from 'i-1' onwards.
        for (int bit = 0; bit < 31; ++bit) {
            if ((nums[i] >> bit) & 1) {
                last_seen_idx[bit] = i;
            }
        }
    }

    free(max_or_suffix); // Free the temporary array
    return ans; // Return the result array
}