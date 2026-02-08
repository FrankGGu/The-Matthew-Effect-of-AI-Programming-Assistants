#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumSum(int* nums, int numsSize) {
    int minSum = INT_MAX;
    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            for (int k = j + 1; k < numsSize; k++) {
                if (nums[i] < nums[j] && nums[j] > nums[k]) {
                    int currentSum = nums[i] + nums[j] + nums[k];
                    if (currentSum < minSum) {
                        minSum = currentSum;
                    }
                }
            }
        }
    }
    if (minSum == INT_MAX) {
        return -1;
    }
    return minSum;
}