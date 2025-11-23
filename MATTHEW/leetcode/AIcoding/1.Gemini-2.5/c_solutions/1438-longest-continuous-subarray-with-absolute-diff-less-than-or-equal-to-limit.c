#include <stdlib.h> // Required for abs, though not directly used in the final version as max-min is always non-negative.
                    // Also for potential malloc/free if dynamic arrays were used, but VLA is used here.

#define MAX(a, b) ((a) > (b) ? (a) : (b))

int longestSubarray(int* nums, int numsSize, int limit) {
    if (numsSize == 0) {
        return 0;
    }

    // Deques to store indices of elements.
    // max_deque will store indices such that nums[index] values are in decreasing order.
    // min_deque will store indices such that nums[index] values are in increasing order.
    // These are implemented as arrays with front and rear pointers.
    int max_deque[numsSize];
    int max_front = 0, max_rear = -1; // max_rear points to the last element added

    int min_deque[numsSize];
    int min_front = 0, min_rear = -1; // min_rear points to the last element added

    int left = 0;
    int max_len = 0;

    for (int right = 0; right < numsSize; ++right) {
        // Maintain max_deque: remove elements from the back that are less than or equal to nums[right]
        while (max_front <= max_rear && nums[max_deque[max_rear]] <= nums[right]) {
            max_rear--;
        }
        max_deque[++max_rear] = right; // Add current index to the back

        // Maintain min_deque: remove elements from the back that are greater than or equal to nums[right]
        while (min_front <= min_rear && nums[min_deque[min_rear]] >= nums[right]) {
            min_rear--;
        }
        min_deque[++min_rear] = right; // Add current index to the back

        // Check the window condition: nums[max_element] - nums[min_element] <= limit
        // If the condition is violated, shrink the window from the left
        while (nums[max_deque[max_front]] - nums[min_deque[min_front]] > limit) {
            left++; // Move the left pointer of the window

            // Remove elements from the front of deques if their index is no longer within the current window [left, right]
            if (max_deque[max_front] < left) {
                max_front++;
            }
            if (min_deque[min_front] < left) {
                min_front++;
            }
        }

        // Update the maximum length of a valid subarray
        max_len = MAX(max_len, right - left + 1);
    }

    return max_len;
}