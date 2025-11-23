#include <stdio.h>
#include <stdlib.h>

long long maxSubarraySum(int* nums, int numsSize) {
    long long maxCurrent = nums[0];
    long long maxGlobal = nums[0];

    for (int i = 1; i < numsSize; i++) {
        maxCurrent = (nums[i] > maxCurrent + nums[i]) ? nums[i] : maxCurrent + nums[i];
        if (maxCurrent > maxGlobal) {
            maxGlobal = maxCurrent;
        }
    }

    return maxGlobal;
}