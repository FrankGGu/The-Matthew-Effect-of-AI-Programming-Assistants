#include <stdio.h>
#include <stdlib.h>

int maximumSubarraySum(int* nums, int numsSize) {
    int n = numsSize;
    int maxSum = INT_MIN;
    int currentSum = 0;
    int left = 0;
    int removeIndex = -1;

    for (int right = 0; right < n; right++) {
        currentSum += nums[right];

        while (currentSum < 0 && left <= right) {
            currentSum -= nums[left];
            left++;
        }

        if (left <= right) {
            maxSum = fmax(maxSum, currentSum);
        }
    }

    return maxSum;
}