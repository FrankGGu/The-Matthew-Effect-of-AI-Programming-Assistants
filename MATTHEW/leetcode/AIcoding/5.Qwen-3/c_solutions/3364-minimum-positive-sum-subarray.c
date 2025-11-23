#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int minPositiveSumSubarray(int* nums, int numsSize) {
    int minSum = INT_MAX;
    int currentSum = 0;
    int hasPositive = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > 0) {
            hasPositive = 1;
        }
        currentSum += nums[i];
        if (currentSum > 0) {
            minSum = (currentSum < minSum) ? currentSum : minSum;
        } else {
            currentSum = 0;
        }
    }

    return hasPositive ? minSum : -1;
}