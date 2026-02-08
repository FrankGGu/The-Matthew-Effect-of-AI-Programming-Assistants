#include <stdlib.h> // For qsort

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int findLHS(int* nums, int numsSize) {
    if (numsSize < 2) {
        return 0;
    }

    qsort(nums, numsSize, sizeof(int), compare);

    int maxLen = 0;
    int left = 0;

    for (int right = 0; right < numsSize; ++right) {
        // Shrink the window from the left if the difference between current right and left element is greater than 1.
        // This ensures that the window always contains elements whose min and max difference is 0 or 1.
        while (nums[right] - nums[left] > 1) {
            left++;
        }

        // If the difference between the current right and left element is exactly 1,
        // we have found a harmonious subsequence.
        if (nums[right] - nums[left] == 1) {
            // Update maxLen with the length of the current harmonious subsequence.
            // The length is (right - left + 1) because both pointers are 0-indexed.
            if (right - left + 1 > maxLen) {
                maxLen = right - left + 1;
            }
        }
    }

    return maxLen;
}