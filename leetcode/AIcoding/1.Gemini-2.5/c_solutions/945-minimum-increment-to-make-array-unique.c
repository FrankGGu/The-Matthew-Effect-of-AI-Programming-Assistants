#include <stdlib.h>

int compareIntegers(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minIncrementForUnique(int* nums, int numsSize) {
    if (numsSize <= 1) {
        return 0;
    }

    qsort(nums, numsSize, sizeof(int), compareIntegers);

    int increments = 0;
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] <= nums[i-1]) {
            int needed_val = nums[i-1] + 1;
            increments += (needed_val - nums[i]);
            nums[i] = needed_val;
        }
    }

    return increments;
}