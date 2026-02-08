#include <stdlib.h> // For malloc, free

int findMaxLength(int* nums, int numsSize) {
    // The sum can range from -numsSize to numsSize.
    // We need to map these sums to non-negative indices for an array.
    // Offset by numsSize: sum_index = sum + numsSize
    // So, -numsSize maps to 0, 0 maps to numsSize, numsSize maps to 2*numsSize.
    // Array size needed: 2*numsSize + 1
    int mapSize = 2 * numsSize + 1;
    int* map = (int*)malloc(mapSize * sizeof(int));

    // Handle allocation failure, though LeetCode usually assumes success
    if (map == NULL) {
        return 0; 
    }

    // Initialize map with a value indicating "not seen".
    // -2 is a good choice as indices are >= 0 and -1 is used for initial sum 0.
    for (int i = 0; i < mapSize; i++) {
        map[i] = -2;
    }

    int sum = 0;
    int maxLength = 0;

    // The sum 0 is considered to be seen at index -1 (before the array starts)
    // This handles cases where a prefix sum itself is 0, e.g., [0, 1] -> sum=0 at index 1.
    map[0 + numsSize] = -1; 

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 0) {
            sum--;
        } else { // nums[i] == 1
            sum++;
        }

        int currentMapIndex = sum + numsSize;

        if (map[currentMapIndex] != -2) { // If this sum has been seen before
            // Calculate length of subarray with equal 0s and 1s
            // (current index) - (first index where this sum was seen)
            maxLength = (i - map[currentMapIndex] > maxLength) ? (i - map[currentMapIndex]) : maxLength;
        } else { // First time seeing this sum
            map[currentMapIndex] = i;
        }
    }

    free(map);
    return maxLength;
}