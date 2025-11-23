#include <stdio.h>
#include <stdlib.h>

int missingNumber(int* nums, int numsSize) {
    int n = numsSize;
    int expectedSum = n * (n + 1) / 2;
    int actualSum = 0;
    for (int i = 0; i < n; i++) {
        actualSum += nums[i];
    }
    return expectedSum - actualSum;
}