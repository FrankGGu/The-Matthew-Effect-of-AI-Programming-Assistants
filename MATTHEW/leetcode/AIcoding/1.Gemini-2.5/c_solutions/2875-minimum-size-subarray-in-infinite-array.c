#include <limits.h> // For INT_MAX

static inline int min(int a, int b) {
    return a < b ? a : b;
}

long long minSizeSubarray(int* nums, int numsSize, int target) {
    long long sum_nums = 0;
    for (int i = 0; i < numsSize; i++) {
        sum_nums += nums[i];
    }

    long long total_length = 0;
    int remaining_target_val = target;

    // Calculate length from full repetitions of nums
    // sum_nums is guaranteed to be >= 1 as nums[i] >= 1
    total_length += (long long)(target / sum_nums) * numsSize;
    remaining_target_val = target % sum_nums;

    // If remaining_target_val is 0, it means target was a multiple of sum_nums.
    // The total_length already accounts for this.
    if (remaining_target_val == 0) {
        return total_length;
    }

    // Use a sliding window to find the minimum length subarray for remaining_target_val
    // This subarray can span across the wrap-around point, so we effectively search in 2 * numsSize elements.
    int min_len_for_remaining = INT_MAX;
    long long current_window_sum = 0;
    int left = 0;

    // Iterate up to 2 * numsSize to handle wrap-around subarrays
    for (int right = 0; right < 2 * numsSize; right++) {
        // Use modulo to access nums array for infinite repetition
        int current_val = nums[right % numsSize]; 
        current_window_sum += current_val;

        while (current_window_sum >= remaining_target_val) {
            if (current_window_sum == remaining_target_val) {
                min_len_for_remaining = min(min_len_for_remaining, right - left + 1);
            }
            // Subtract element from left of window, using modulo for infinite repetition
            current_window_sum -= nums[left % numsSize]; 
            left++;
        }
    }

    // If min_len_for_remaining is still INT_MAX, it means no subarray was found for remaining_target_val.
    // This implies the target cannot be formed. In such a case, return -1.
    if (min_len_for_remaining == INT_MAX) {
        return -1; // Target cannot be formed
    }

    total_length += min_len_for_remaining;

    return total_length;
}