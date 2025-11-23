#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int kConcatenation(int* nums, int numsSize) {
    long maxEndingHere = 0;
    long maxSoFar = 0;
    long total = 0;

    for (int i = 0; i < numsSize; ++i) {
        total += nums[i];
        maxEndingHere = fmax(nums[i], maxEndingHere + nums[i]);
        maxSoFar = fmax(maxSoFar, maxEndingHere);
    }

    if (numsSize == 1) return nums[0] > 0 ? nums[0] : 0;

    long maxPrefix = 0;
    long current = 0;
    for (int i = 0; i < numsSize; ++i) {
        current += nums[i];
        maxPrefix = fmax(maxPrefix, current);
    }

    long maxSuffix = 0;
    current = 0;
    for (int i = numsSize - 1; i >= 0; --i) {
        current += nums[i];
        maxSuffix = fmax(maxSuffix, current);
    }

    long maxTwo = maxPrefix + maxSuffix;

    return fmax(maxSoFar, maxTwo + (total > 0 ? total : 0)) % INT_MAX;
}