#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int maxAbsoluteSum(int* nums, int numsSize) {
    int maxEndingHere = nums[0];
    int maxSoFar = nums[0];
    int minEndingHere = nums[0];
    int minSoFar = nums[0];
    int maxAbs = abs(nums[0]);

    for (int i = 1; i < numsSize; i++) {
        maxEndingHere = fmax(nums[i], maxEndingHere + nums[i]);
        maxSoFar = fmax(maxSoFar, maxEndingHere);

        minEndingHere = fmin(nums[i], minEndingHere + nums[i]);
        minSoFar = fmin(minSoFar, minEndingHere);

        maxAbs = fmax(maxAbs, abs(maxSoFar), abs(minSoFar));
    }

    return maxAbs;
}