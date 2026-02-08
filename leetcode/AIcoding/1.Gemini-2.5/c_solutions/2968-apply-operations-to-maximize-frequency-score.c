#include <stdlib.h> // For qsort

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maxFrequency(int* nums, int numsSize, int k) {
    // Sort the array in non-decreasing order
    qsort(nums, numsSize, sizeof(int), compare);

    long long current_sum = 0;
    int left = 0;
    int max_freq = 0;

    // Iterate with the right pointer to expand the window
    for (int right = 0; right < numsSize; ++right) {
        current_sum += nums[right];

        // Calculate the cost to make all elements in the current window [left...right]
        // equal to nums[right].
        // The cost is (target_value * number_of_elements) - sum_of_elements_in_window
        long long cost = (long long)nums[right] * (right - left + 1) - current_sum;

        // If the cost exceeds k, shrink the window from the left
        while (cost > k) {
            current_sum -= nums[left];
            left++;
            // Recalculate cost with the new, smaller window
            cost = (long long)nums[right] * (right - left + 1) - current_sum;
        }

        // The current window [left...right] is valid. Update max_freq if this window is larger.
        if (right - left + 1 > max_freq) {
            max_freq = right - left + 1;
        }
    }

    return max_freq;
}