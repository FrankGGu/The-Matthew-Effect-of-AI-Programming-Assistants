#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumSum(int* nums, int numsSize) {
    int minSum = INT_MAX;
    int prefixMin[numsSize];
    int suffixMin[numsSize];

    prefixMin[0] = nums[0];
    for (int i = 1; i < numsSize; i++) {
        prefixMin[i] = (nums[i] < prefixMin[i - 1]) ? nums[i] : prefixMin[i - 1];
    }

    suffixMin[numsSize - 1] = nums[numsSize - 1];
    for (int i = numsSize - 2; i >= 0; i--) {
        suffixMin[i] = (nums[i] < suffixMin[i + 1]) ? nums[i] : suffixMin[i + 1];
    }

    for (int j = 1; j < numsSize - 1; j++) {
        if (prefixMin[j - 1] < nums[j] && suffixMin[j + 1] < nums[j]) {
            int currentSum = prefixMin[j - 1] + nums[j] + suffixMin[j + 1];
            if (currentSum < minSum) {
                minSum = currentSum;
            }
        }
    }

    return (minSum == INT_MAX) ? -1 : minSum;
}