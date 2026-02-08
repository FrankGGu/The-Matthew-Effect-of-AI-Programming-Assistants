#include <stdio.h>
#include <stdlib.h>

int minSumMountainTriplets(int* nums, int numsSize) {
    int minSum = INT_MAX;
    for (int i = 1; i < numsSize - 1; i++) {
        int leftMin = nums[0];
        for (int j = 0; j < i; j++) {
            if (nums[j] < nums[i]) {
                leftMin = nums[j];
                break;
            }
        }
        int rightMin = nums[numsSize - 1];
        for (int k = numsSize - 1; k > i; k--) {
            if (nums[k] < nums[i]) {
                rightMin = nums[k];
                break;
            }
        }
        if (leftMin < nums[i] && nums[i] > rightMin) {
            minSum = fmin(minSum, leftMin + nums[i] + rightMin);
        }
    }
    return minSum == INT_MAX ? -1 : minSum;
}