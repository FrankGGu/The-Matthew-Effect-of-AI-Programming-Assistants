#include <stdio.h>
#include <stdlib.h>

int minSubarrayLen(int target, int* nums, int numsSize) {
    int n = numsSize;
    int minLen = INT_MAX;
    int left = 0;
    int currentSum = 0;

    for (int right = 0; right < n; right++) {
        currentSum += nums[right];

        while (currentSum >= target) {
            minLen = fmin(minLen, right - left + 1);
            currentSum -= nums[left];
            left++;
        }
    }

    return minLen == INT_MAX ? 0 : minLen;
}