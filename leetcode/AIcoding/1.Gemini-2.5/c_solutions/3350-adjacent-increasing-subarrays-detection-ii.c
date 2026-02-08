#include <stdbool.h>
#include <stdlib.h>

bool canBeSplitIntoTwoIncreasingSubarrays(int* nums, int numsSize) {
    if (numsSize < 2) {
        return false;
    }

    // prefix_inc[i] is true if the subarray nums[0...i] is strictly increasing
    bool* prefix_inc = (bool*)malloc(numsSize * sizeof(bool));
    if (prefix_inc == NULL) {
        return false; // Allocation failed
    }

    prefix_inc[0] = true;
    for (int i = 1; i < numsSize; i++) {
        prefix_inc[i] = prefix_inc[i-1] && (nums[i] > nums[i-1]);
    }

    // suffix_inc[i] is true if the subarray nums[i...numsSize-1] is strictly increasing
    bool* suffix_inc = (bool*)malloc(numsSize * sizeof(bool));
    if (suffix_inc == NULL) {
        free(prefix_inc); // Clean up previously allocated memory
        return false; // Allocation failed
    }

    suffix_inc[numsSize - 1] = true;
    for (int i = numsSize - 2; i >= 0; i--) {
        suffix_inc[i] = suffix_inc[i+1] && (nums[i] < nums[i+1]);
    }

    // Iterate through all possible split points 'i'
    // 'i' represents the last index of the first subarray (nums[0...i])
    // The second subarray starts at 'i+1' (nums[i+1...numsSize-1])
    // Both subarrays must be non-empty, so 'i' can range from 0 to numsSize - 2.
    for (int i = 0; i < numsSize - 1; i++) {
        if (prefix_inc[i] && suffix_inc[i+1]) {
            free(prefix_inc);
            free(suffix_inc);
            return true;
        }
    }

    free(prefix_inc);
    free(suffix_inc);
    return false;
}