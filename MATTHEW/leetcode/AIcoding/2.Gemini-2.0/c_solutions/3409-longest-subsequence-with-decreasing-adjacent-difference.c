#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestSubsequence(int* nums, int numsSize, int difference) {
    int maxLen = 0;
    int dp[100001] = {0};
    int offset = 50000;

    for (int i = 0; i < numsSize; i++) {
        int prev = nums[i] + difference;
        int currentLen = 1;
        if (prev >= nums[i] - offset && prev <= nums[i] + offset && dp[prev + offset] > 0) {
            currentLen = dp[prev + offset] + 1;
        }
        dp[nums[i] + offset] = currentLen;
        if (currentLen > maxLen) {
            maxLen = currentLen;
        }
    }

    return maxLen;
}