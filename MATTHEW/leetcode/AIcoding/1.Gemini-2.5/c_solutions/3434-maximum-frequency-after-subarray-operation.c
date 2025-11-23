#include <stdlib.h> // Required for qsort

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maxFrequency(int* nums, int numsSize, int k) {
    // Sort the array in ascending order. This is crucial for the sliding window approach.
    qsort(nums, numsSize, sizeof(int), compare);

    long long current_sum = 0; // Use long long to prevent overflow for sum of elements
    int left = 0;
    int max_freq = 0;

    // Iterate with 'right' pointer to expand the window
    for (int right = 0; right < numsSize; right++) {
        current_sum += nums[right];

        // The cost to make all elements in the current window [left, right] equal to nums[right]
        // is (length of window) * nums[right] - (sum of elements in window).
        // If this cost exceeds k, the window is invalid. Shrink it from the left.
        while ((long long)(right - left + 1) * nums[right] - current_sum > k) {
            current_sum -= nums[left];
            left++;
        }

        // At this point, the window [left, right] is valid.
        // Its length (right - left + 1) is a possible maximum frequency.
        int current_window_length = right - left + 1;
        if (current_window_length > max_freq) {
            max_freq = current_window_length;
        }
    }

    return max_freq;
}