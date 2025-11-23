#include <stdio.h>
#include <stdlib.h>

int minImpossibleOR(int* nums, int numsSize) {
    int* seen = (int*)calloc(1 << 16, sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] < (1 << 16)) {
            seen[nums[i]] = 1;
        }
    }

    for (int i = 1; i < (1 << 16); i <<= 1) {
        if (!seen[i]) {
            free(seen);
            return i;
        }
    }

    free(seen);
    return (1 << 16);
}