#include <stddef.h> // Required for size_t, though not strictly used for numsSize in this solution

int longestNiceSubarray(int* nums, int numsSize) {
    int left = 0;
    int max_len = 0;
    // bit_counts[k] stores the number of elements in the current window [left, right]
    // that have the k-th bit set.
    // Numbers are up to 1000, which is 0b1111101000, so bits 0-9 are relevant.
    int bit_counts[10] = {0}; 

    for (int right = 0; right < numsSize; ++right) {
        int num = nums[right];

        // Add nums[right] to the window and update bit_counts
        for (int k = 0; k < 10; ++k) {
            if ((num >> k) & 1) {
                bit_counts[k]++;
            }
        }

        // Shrink window from left if the current window [left, right] is not nice
        // A window is not nice if for any bit k, that bit is set in some numbers
        // but not all numbers within the window.
        // This means bit_counts[k] > 0 (set in some) AND bit_counts[k] < current_window_size (not set in all).
        while (1) {
            int current_window_size = right - left + 1;
            int is_window_nice = 1; // Assume the current window is nice

            for (int k = 0; k < 10; ++k) {
                // If a bit is set in at least one number (bit_counts[k] > 0)
                // but not in all numbers (bit_counts[k] < current_window_size),
                // then the window is not nice.
                if (bit_counts[k] > 0 && bit_counts[k] < current_window_size) {
                    is_window_nice = 0; // Found a bit that violates the condition
                    break;
                }
            }

            if (is_window_nice) {
                break; // Window is nice, stop shrinking and proceed to update max_len
            }

            // If the window is not nice, remove nums[left] from the window
            // and update bit_counts accordingly.
            int removed_num = nums[left];
            for (int k = 0; k < 10; ++k) {
                if ((removed_num >> k) & 1) {
                    bit_counts[k]--;
                }
            }
            left++; // Move the left pointer to shrink the window
        }

        // After ensuring the current window [left, right] is nice,
        // update the maximum length found so far.
        if ((right - left + 1) > max_len) {
            max_len = (right - left + 1);
        }
    }

    return max_len;
}