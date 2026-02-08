#include <stdlib.h> // Required for qsort

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int min(int a, int b) {
    return a < b ? a : b;
}

int minDifference(int* nums, int numsSize) {
    // If numsSize is 4 or less, we can make all elements equal in at most 3 moves.
    // For example, if numsSize = 4, we can change 3 elements to match the 4th.
    // The difference will be 0.
    if (numsSize <= 4) {
        return 0;
    }

    // Sort the array to easily identify the smallest and largest elements.
    qsort(nums, numsSize, sizeof(int), compare);

    // After sorting, we need to consider the four scenarios for removing 3 elements
    // to minimize the difference between the largest and smallest remaining values.
    // This is equivalent to choosing a subarray of size (numsSize - 3) and
    // finding the difference between its max and min.

    // Scenario 1: Remove the 3 smallest elements.
    // The remaining range is from nums[3] to nums[numsSize - 1].
    int diff1 = nums[numsSize - 1] - nums[3];

    // Scenario 2: Remove the 2 smallest elements and 1 largest element.
    // The remaining range is from nums[2] to nums[numsSize - 2].
    int diff2 = nums[numsSize - 2] - nums[2];

    // Scenario 3: Remove the 1 smallest element and 2 largest elements.
    // The remaining range is from nums[1] to nums[numsSize - 3].
    int diff3 = nums[numsSize - 3] - nums[1];

    // Scenario 4: Remove the 3 largest elements.
    // The remaining range is from nums[0] to nums[numsSize - 4].
    int diff4 = nums[numsSize - 4] - nums[0];

    // The minimum difference will be the smallest among these four scenarios.
    return min(min(diff1, diff2), min(diff3, diff4));
}