#include <stdbool.h>
#include <stdlib.h> // For malloc and free

bool isIdealPermutation(int* nums, int numsSize) {
    if (numsSize <= 2) {
        return true;
    }

    // min_suffix[k] stores the minimum value in nums[k...numsSize-1]
    int* min_suffix = (int*)malloc(sizeof(int) * numsSize);

    min_suffix[numsSize - 1] = nums[numsSize - 1];
    for (int i = numsSize - 2; i >= 0; --i) {
        if (nums[i] < min_suffix[i + 1]) {
            min_suffix[i] = nums[i];
        } else {
            min_suffix[i] = min_suffix[i + 1];
        }
    }

    // Check for global inversions that are not local inversions
    // A global inversion (i, j) is not local if j > i + 1
    // This means nums[i] > nums[j] for some j >= i + 2
    // Which is equivalent to nums[i] > min(nums[i+2], ..., nums[numsSize-1])
    for (int i = 0; i <= numsSize - 3; ++i) {
        // We need min_suffix[i+2]
        if (nums[i] > min_suffix[i + 2]) {
            free(min_suffix);
            return false;
        }
    }

    free(min_suffix);
    return true;
}