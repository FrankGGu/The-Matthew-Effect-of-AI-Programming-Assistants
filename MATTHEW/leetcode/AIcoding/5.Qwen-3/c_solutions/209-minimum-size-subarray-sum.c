#include <stdio.h>
#include <stdlib.h>

int minSubArrayLen(int target, int* nums, int numsSize) {
    int left = 0;
    int currentSum = 0;
    int minLength = INT_MAX;

    for (int right = 0; right < numsSize; right++) {
        currentSum += nums[right];

        while (currentSum >= target) {
            minLength = fmin(minLength, right - left + 1);
            currentSum -= nums[left];
            left++;
        }
    }

    return minLength == INT_MAX ? 0 : minLength;
}