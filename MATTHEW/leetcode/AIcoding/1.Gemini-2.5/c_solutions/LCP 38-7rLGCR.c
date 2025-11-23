#include <stdlib.h> // For calloc, free

int max(int a, int b) {
    return a > b ? a : b;
}

int longestEqualSubarray(int* nums, int numsSize, int k) {
    // freq array to store the count of each number in the current window.
    // nums[i] values are between 1 and numsSize, so an array of size numsSize + 1 is sufficient.
    // calloc initializes all elements to zero.
    int* freq = (int*)calloc(numsSize + 1, sizeof(int));
    if (freq == NULL) {
        // Handle memory allocation failure if necessary.
        // For LeetCode, typically malloc/calloc succeed for reasonable sizes.
        return 0;
    }

    int left = 0; // Left pointer of the sliding window
    int maxFreq = 0; // Maximum frequency of any number in the current window
    int ans = 0;     // Stores the maximum length of an equal subarray found

    // Iterate with the right pointer to expand the window
    for (int right = 0; right < numsSize; right++) {
        // Add the current element to the window and update its frequency
        freq[nums[right]]++;
        // Update maxFreq: it tracks the maximum frequency of any number seen so far in the window.
        // This maxFreq is non-decreasing.
        maxFreq = max(maxFreq, freq[nums[right]]);

        // Check if the current window is valid.
        // A window is valid if (current_window_length - maxFreq) <= k.
        // (current_window_length - maxFreq) represents the number of elements that are NOT the most frequent one.
        // These are the elements we would need to remove.
        // If this count exceeds k, the window is invalid and must be shrunk from the left.
        while ((right - left + 1) - maxFreq > k) {
            // Remove the element at the left pointer from the window
            freq[nums[left]]--;
            // Shrink the window by moving the left pointer
            left++;
            // Note: maxFreq is NOT re-calculated here. It remains the maximum frequency
            // observed in any window that has been valid up to this point.
            // This is a common optimization for this type of sliding window problem.
            // The logic still holds because if a window with a potentially overestimated maxFreq
            // is invalid, then a window with the true maxFreq (which is <= maxFreq)
            // would also be invalid or require even more removals.
        }

        // After the while loop, the window [left, right] is guaranteed to be valid.
        // The length of the equal subarray we can form is maxFreq.
        // We want to find the maximum possible maxFreq.
        ans = max(ans, maxFreq);
    }

    // Free the allocated memory
    free(freq);

    return ans;
}