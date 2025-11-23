#include <stdlib.h> // Required for qsort

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maxFrequency(int* nums, int numsSize, int k) {
    // Sort the array in non-decreasing order
    qsort(nums, numsSize, sizeof(int), compare);

    long long current_sum = 0; // Use long long for sum to prevent overflow
    int left = 0;
    int max_freq = 0;

    for (int right = 0; right < numsSize; right++) {
        current_sum += nums[right];

        // While the cost to make all elements in the window [left, right] equal to nums[right]
        // exceeds k, shrink the window from the left.
        // The cost is calculated as: (target_sum_for_window - actual_sum_of_window)
        // target_sum_for_window = nums[right] * (length_of_window)
        // length_of_window = (right - left + 1)
        while ((long long)nums[right] * (right - left + 1) - current_sum > k) {
            current_sum -= nums[left];
            left++;
        }

        // The current window [left, right] is valid.
        // Update max_freq with the length of this valid window.
        if (right - left + 1 > max_freq) {
            max_freq = right - left + 1;
        }
    }

    return max_freq;
}