#include <stdio.h>
#include <stdlib.h>

int findMaxK(int* nums, int numsSize) {
    int maxK = -1;
    int* seen = (int*)calloc(1001, sizeof(int));

    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        if (num > 0) {
            seen[num] = 1;
        }
    }

    for (int i = 1000; i >= 1; i--) {
        if (seen[i] && (i * -1) == -i) {
            return i;
        }
    }

    free(seen);
    return -1;
}