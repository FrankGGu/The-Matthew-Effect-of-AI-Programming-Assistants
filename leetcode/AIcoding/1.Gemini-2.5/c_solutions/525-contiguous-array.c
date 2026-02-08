#include <stdlib.h>
#include <string.h> // For memset
#include <math.h>   // For fmax

int findMaxLength(int* nums, int numsSize) {
    if (numsSize == 0) {
        return 0;
    }

    // The sum can range from -numsSize to numsSize.
    // We need an array to map sums to their first occurrence index.
    // To handle negative sums, we offset the sum by numsSize.
    // So, an actual sum 's' will be mapped to index 's + numsSize'.
    // The array size needs to be 2 * numsSize + 1.
    int mapSize = 2 * numsSize + 1;
    int* sumMap = (int*)malloc(sizeof(int) * mapSize);

    // Initialize map with -2 to indicate that no sum has been seen yet.
    // -1 is reserved for the initial sum of 0 (before processing any elements).
    // Any valid index will be >= 0.
    memset(sumMap, -2, sizeof(int) * mapSize);

    // Initial state: a sum of 0 occurs at index -1 (conceptually, before the array starts).
    // This allows us to correctly calculate the length of subarrays starting from index 0
    // that have a sum of 0.
    sumMap[numsSize] = -1;

    int currentSum = 0;
    int maxLength = 0;

    for (int i = 0; i < numsSize; ++i) {
        // Transform 0s to -1s and 1s to 1s.
        currentSum += (nums[i] == 0 ? -1 : 1);

        // Calculate the mapped index for the current sum.
        int mapIndex = currentSum + numsSize;

        // If this sum has been seen before:
        if (sumMap[mapIndex] != -2) {
            // The length of the contiguous subarray with equal 0s and 1s
            // is the current index minus the first index where this sum was encountered.
            maxLength = fmax(maxLength, i - sumMap[mapIndex]);
        } else {
            // If this is the first time we've seen this sum, record its index.
            sumMap[mapIndex] = i;
        }
    }

    free(sumMap);
    return maxLength;
}