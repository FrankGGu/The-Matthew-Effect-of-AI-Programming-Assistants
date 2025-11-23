#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return *(int*)a - *(int*)b;
}

bool containsNearbyAlmostDuplicate(int* nums, int numsSize, int k, int t) {
    if (numsSize <= 1 || k < 1) return false;

    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize && j <= i + k; j++) {
            long diff = (long)nums[i] - (long)nums[j];
            if (abs(diff) <= t) {
                return true;
            }
        }
    }
    return false;
}