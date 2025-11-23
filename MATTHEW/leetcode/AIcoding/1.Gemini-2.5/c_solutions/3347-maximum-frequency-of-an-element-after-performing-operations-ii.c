#include <stdlib.h> // For qsort
#include <stdio.h>  // Not strictly needed for the solution, but common for C problems

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maxFrequency(int* nums, int numsSize, int k) {
    // Sort the array to use the sliding window approach
    qsort(nums, numsSize, sizeof(int), compare);

    long long current_sum = 0;
    int left = 0;
    int max_freq = 0;

    for (int right = 0; right < numsSize; ++right) {
        current_sum += nums[right];

        // The condition for the current window [left, right] to be valid is:
        // (nums[right] * window_size) - current_sum <= k
        // If this condition is violated, we need to shrink the window from the left.
        while ((long long)nums[right] * (right - left + 1) - current_sum > k) {
            current_sum -= nums[left];
            left++;
        }

        // After potentially shrinking the window, the current window [left, right] is valid.
        // Update max_freq with the current window size.
        if (right - left + 1 > max_freq) {
            max_freq = right - left + 1;
        }
    }

    return max_freq;
}