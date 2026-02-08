#include <stdio.h>
#include <stdlib.h>

int findSmallestInteger(int* nums, int numsSize) {
    int* seen = (int*)calloc(numsSize + 1, sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] <= numsSize) {
            seen[nums[i]]++;
        }
    }

    for (int i = 0; i <= numsSize; i++) {
        if (seen[i] == 0) {
            free(seen);
            return i;
        }
    }

    free(seen);
    return numsSize;
}