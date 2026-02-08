#include <limits.h>
#include <stdio.h>

int min(int a, int b) {
    return a < b ? a : b;
}

int minSubArrayLen(int target, int* nums, int numsSize) {
    int minLen = INT_MAX;
    int currentSum = 0;
    int left = 0;

    for (int right = 0; right < numsSize; right++) {
        currentSum += nums[right];

        while (currentSum >= target) {
            minLen = min(minLen, right - left + 1);
            currentSum -= nums[left];
            left++;
        }
    }

    return (minLen == INT_MAX) ? 0 : minLen;
}