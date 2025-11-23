#include <stdbool.h>
#include <stdlib.h>

int compareIntegers(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

bool isStraight(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), compareIntegers);

    int zeroCount = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 0) {
            zeroCount++;
        } else if (i > 0 && nums[i] == nums[i-1] && nums[i-1] != 0) {
            return false;
        }
    }

    int gap = 0;
    int firstNonZeroIdx = zeroCount;
    for (int i = firstNonZeroIdx; i < numsSize - 1; i++) {
        gap += (nums[i+1] - nums[i] - 1);
    }

    return zeroCount >= gap;
}