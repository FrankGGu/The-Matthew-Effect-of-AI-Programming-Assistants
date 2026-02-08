#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximumUniqueSubarray(int* nums, int numsSize){
    int left = 0;
    int right = 0;
    int currentSum = 0;
    int maxSum = 0;
    bool seen[10001] = {false};

    while (right < numsSize) {
        while (seen[nums[right]]) {
            currentSum -= nums[left];
            seen[nums[left]] = false;
            left++;
        }

        currentSum += nums[right];
        seen[nums[right]] = true;
        maxSum = (currentSum > maxSum) ? currentSum : maxSum;
        right++;
    }

    return maxSum;
}