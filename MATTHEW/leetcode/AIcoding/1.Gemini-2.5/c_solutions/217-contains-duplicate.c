#include <stdbool.h>
#include <stdlib.h>

int compareIntegers(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

bool containsDuplicate(int* nums, int numsSize) {
    if (numsSize <= 1) {
        return false;
    }

    // Sort the array
    qsort(nums, numsSize, sizeof(int), compareIntegers);

    // Check for adjacent duplicates
    for (int i = 0; i < numsSize - 1; i++) {
        if (nums[i] == nums[i+1]) {
            return true;
        }
    }

    return false;
}