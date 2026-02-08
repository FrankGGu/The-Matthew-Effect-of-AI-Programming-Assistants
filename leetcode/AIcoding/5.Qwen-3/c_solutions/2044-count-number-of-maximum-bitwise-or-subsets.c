#include <stdio.h>
#include <stdlib.h>

int countMaxOrSubsets(int* nums, int numsSize) {
    int maxOr = 0;
    for (int i = 0; i < numsSize; ++i) {
        maxOr |= nums[i];
    }

    int count = 0;
    int n = numsSize;
    for (int mask = 1; mask < (1 << n); ++mask) {
        int currentOr = 0;
        for (int i = 0; i < n; ++i) {
            if (mask & (1 << i)) {
                currentOr |= nums[i];
            }
        }
        if (currentOr == maxOr) {
            ++count;
        }
    }

    return count;
}