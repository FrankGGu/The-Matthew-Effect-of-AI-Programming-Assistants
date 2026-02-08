#include <limits.h> // For INT_MAX

static int min(int a, int b) {
    return a < b ? a : b;
}

int shortestSubarrayWithOR(int* nums, int numsSize, int k) {
    int min_len = INT_MAX;
    int l = 0;
    // bit_counts[j] stores the number of elements in the current window [l, r]
    // that have the j-th bit set. Max value of nums[i] is 10^9, which fits in 30 bits.
    int bit_counts[30] = {0}; 

    for (int r = 0; r < numsSize; ++r) {
        // Add nums[r] to the window
        for (int j = 0; j < 30; ++j) {
            if ((nums[r] >> j) & 1) {
                bit_counts[j]++;
            }
        }

        // Calculate the bitwise OR of elements in the current window [l, r]
        int current_or = 0;
        for (int j = 0; j < 30; ++j) {
            if (bit_counts[j] > 0) {
                current_or |= (1 << j);
            }
        }

        // While the current OR value is at least k, try to shrink the window from the left
        while (current_or >= k && l <= r) {
            // Update the minimum length found so far
            min_len = min(min_len, r - l + 1);

            // Remove nums[l] from the window
            for (int j = 0; j < 30; ++j) {
                if ((nums[l] >> j) & 1) {
                    bit_counts[j]--;
                }
            }
            l++;

            // Recalculate current_or after removing nums[l]
            // This is necessary because removing an element might change the OR value
            // if it was the last element contributing a particular bit.
            current_or = 0;
            for (int j = 0; j < 30; ++j) {
                if (bit_counts[j] > 0) {
                    current_or |= (1 << j);
                }
            }
        }
    }

    // If min_len is still INT_MAX, no such subarray was found
    return (min_len == INT_MAX) ? -1 : min_len;
}