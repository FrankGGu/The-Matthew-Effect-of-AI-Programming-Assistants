#include <stdlib.h> // For qsort

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minIncrementForUnique(int* nums, int numsSize) {
    if (numsSize <= 1) {
        return 0;
    }

    qsort(nums, numsSize, sizeof(int), compare);

    int operations = 0;
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] <= nums[i-1]) {
            int increment_needed = nums[i-1] + 1 - nums[i];
            operations += increment_needed;
            nums[i] = nums[i-1] + 1; // Update nums[i] for subsequent comparisons
        }
    }

    return operations;
}