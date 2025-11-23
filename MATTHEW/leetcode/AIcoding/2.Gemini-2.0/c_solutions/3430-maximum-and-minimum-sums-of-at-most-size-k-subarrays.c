#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxSubarraySum(int* nums, int numsSize, int k) {
    if (numsSize == 0 || k <= 0) {
        return 0;
    }

    if (k > numsSize) {
        k = numsSize;
    }

    int maxSum = INT_MIN;
    for (int i = 0; i <= numsSize - k; i++) {
        int currentSum = 0;
        for (int j = i; j < i + k; j++) {
            currentSum += nums[j];
        }
        if (currentSum > maxSum) {
            maxSum = currentSum;
        }
    }
    return maxSum;
}

int minSubarraySum(int* nums, int numsSize, int k) {
    if (numsSize == 0 || k <= 0) {
        return 0;
    }

    if (k > numsSize) {
        k = numsSize;
    }

    int minSum = INT_MAX;
    for (int i = 0; i <= numsSize - k; i++) {
        int currentSum = 0;
        for (int j = i; j < i + k; j++) {
            currentSum += nums[j];
        }
        if (currentSum < minSum) {
            minSum = currentSum;
        }
    }
    return minSum;
}