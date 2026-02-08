#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minIncrementForUnique(int* nums, int numsSize) {
    if (numsSize <= 1) {
        return 0;
    }

    qsort(nums, numsSize, sizeof(int), compare);

    int moves = 0;
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] <= nums[i - 1]) {
            moves += nums[i - 1] - nums[i] + 1;
            nums[i] = nums[i - 1] + 1;
        }
    }

    return moves;
}

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}