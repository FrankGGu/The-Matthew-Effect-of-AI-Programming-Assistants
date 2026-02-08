#include <stdio.h>
#include <stdlib.h>

int minimumSum(int* nums, int numsSize) {
    int n = numsSize;
    int minSum = INT_MAX;

    for (int i = 1; i < n - 1; i++) {
        int left = 0;
        int right = n - 1;

        while (left < i && nums[left] >= nums[i]) {
            left++;
        }

        while (right > i && nums[right] >= nums[i]) {
            right--;
        }

        if (left < i && right > i) {
            minSum = fmin(minSum, nums[left] + nums[i] + nums[right]);
        }
    }

    return minSum == INT_MAX ? -1 : minSum;
}