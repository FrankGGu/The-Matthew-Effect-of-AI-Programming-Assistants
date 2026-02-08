#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxSumTwoNoOverlap(int* nums, int numsSize, int firstLen, int secondLen) {
    int sum1 = 0, sum2 = 0;
    int maxSum = 0;

    for (int i = 0; i < firstLen; i++) {
        sum1 += nums[i];
    }
    for (int i = firstLen; i < firstLen + secondLen; i++) {
        sum2 += nums[i];
    }
    maxSum = sum1 + sum2;

    int tempSum1 = sum1, tempSum2 = sum2;
    for (int i = firstLen; i < numsSize - secondLen; i++) {
        tempSum1 = tempSum1 - nums[i - firstLen] + nums[i];
        tempSum2 = tempSum2 - nums[i] + nums[i + secondLen];
        maxSum = fmax(maxSum, tempSum1 + tempSum2);
    }

    sum1 = 0, sum2 = 0;
    for (int i = 0; i < secondLen; i++) {
        sum1 += nums[i];
    }
    for (int i = secondLen; i < secondLen + firstLen; i++) {
        sum2 += nums[i];
    }
    maxSum = fmax(maxSum, sum1 + sum2);

    tempSum1 = sum1, tempSum2 = sum2;
    for (int i = secondLen; i < numsSize - firstLen; i++) {
        tempSum1 = tempSum1 - nums[i - secondLen] + nums[i];
        tempSum2 = tempSum2 - nums[i] + nums[i + firstLen];
        maxSum = fmax(maxSum, tempSum1 + tempSum2);
    }

    return maxSum;
}