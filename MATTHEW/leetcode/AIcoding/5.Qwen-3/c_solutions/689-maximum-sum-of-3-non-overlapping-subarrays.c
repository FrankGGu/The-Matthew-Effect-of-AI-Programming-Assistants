#include <stdio.h>
#include <stdlib.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int* dp(int* nums, int numsSize, int k, int* returnSize) {
    int* dp = (int*)malloc(numsSize * sizeof(int));
    int sum = 0;
    for (int i = 0; i < k; i++) {
        sum += nums[i];
    }
    dp[0] = sum;
    for (int i = 1; i <= numsSize - k; i++) {
        sum = sum - nums[i - 1] + nums[i + k - 1];
        dp[i] = sum;
    }
    *returnSize = numsSize - k + 1;
    return dp;
}

int max3(int a, int b, int c) {
    return a > b ? (a > c ? a : c) : (b > c ? b : c);
}

int* maxSumOfThreeSubarrays(int* nums, int numsSize, int k, int* returnSize) {
    int* left = dp(nums, numsSize, k, returnSize);
    int* right = dp(nums, numsSize, k, returnSize);
    int* result = (int*)malloc(3 * sizeof(int));
    int maxSum = 0;
    int* leftMax = (int*)malloc(numsSize * sizeof(int));
    int* rightMax = (int*)malloc(numsSize * sizeof(int));
    leftMax[0] = 0;
    for (int i = 1; i < numsSize - k + 1; i++) {
        leftMax[i] = max(leftMax[i - 1], left[i]);
    }
    rightMax[numsSize - k] = numsSize - k;
    for (int i = numsSize - k - 1; i >= 0; i--) {
        rightMax[i] = max(rightMax[i + 1], right[i]);
    }
    for (int i = k; i < numsSize - k; i++) {
        int leftIndex = leftMax[i - k];
        int rightIndex = rightMax[i + k];
        int currentSum = left[leftIndex] + left[i] + left[rightIndex];
        if (currentSum > maxSum) {
            maxSum = currentSum;
            result[0] = leftIndex;
            result[1] = i;
            result[2] = rightIndex;
        }
    }
    free(left);
    free(right);
    free(leftMax);
    free(rightMax);
    *returnSize = 3;
    return result;
}