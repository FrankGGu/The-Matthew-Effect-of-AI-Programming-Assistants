#include <stdio.h>
#include <stdlib.h>

int findFinalValue(int* nums, int numsSize, int original) {
    int* seen = (int*)calloc(1001, sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        seen[nums[i]] = 1;
    }
    while (seen[original]) {
        original *= 2;
    }
    free(seen);
    return original;
}