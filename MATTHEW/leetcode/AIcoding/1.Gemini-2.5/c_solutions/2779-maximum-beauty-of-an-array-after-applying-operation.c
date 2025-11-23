#include <stdlib.h> // Required for qsort

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maximumBeauty(int* nums, int numsSize, int k) {
    // Sort the array to efficiently find the minimum and maximum elements
    // within any subarray (window) using its endpoints.
    qsort(nums, numsSize, sizeof(int), compare);

    int max_len = 0;
    int left = 0; // Left pointer of the sliding window

    // Iterate with the right pointer to expand the window
    for (int right = 0; right < numsSize; ++right) {
        // The condition for a subarray nums[left...right] to be "beautiful"
        // is that max(nums[left...right]) - min(nums[left...right]) <= 2 * k.
        // Since the array is sorted, this simplifies to nums[right] - nums[left] <= 2 * k.

        // If the current window [left, right] does not satisfy the condition,
        // it means nums[right] - nums[left] > 2 * k.
        // To satisfy the condition, we must shrink the window from the left
        // by incrementing 'left' until the condition is met again.
        while (nums[right] - nums[left] > 2 * k) {
            left++;
        }

        // At this point, the window [left, right] satisfies the beauty condition.
        // Calculate its length and update max_len if it's greater.
        // The length of the current window is (right - left + 1).
        if ((right - left + 1) > max_len) {
            max_len = (right - left + 1);
        }
    }

    return max_len;
}