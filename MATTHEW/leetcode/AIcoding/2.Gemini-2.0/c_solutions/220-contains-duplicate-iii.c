#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    long long x = *(long long *)a;
    long long y = *(long long *)b;
    if (x > y) return 1;
    if (x < y) return -1;
    return 0;
}

bool containsNearbyAlmostDuplicate(int* nums, int numsSize, int k, int t) {
    if (numsSize <= 1 || k < 0 || t < 0) return false;

    long long *nums_long = (long long *)malloc(numsSize * sizeof(long long));
    for (int i = 0; i < numsSize; i++) {
        nums_long[i] = (long long)nums[i];
    }

    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize && j <= i + k; j++) {
            long long diff = nums_long[i] - nums_long[j];
            if (diff < 0) diff = -diff;
            if (diff <= t) {
                free(nums_long);
                return true;
            }
        }
    }

    free(nums_long);
    return false;
}