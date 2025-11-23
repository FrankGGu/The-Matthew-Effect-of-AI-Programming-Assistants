#include <stdio.h>
#include <stdlib.h>

int maxSubArray(int* nums, int numsSize) {
    int max_current = nums[0];
    int max_global = nums[0];

    for (int i = 1; i < numsSize; i++) {
        max_current = (nums[i] > max_current + nums[i]) ? nums[i] : max_current + nums[i];
        if (max_current > max_global) {
            max_global = max_current;
        }
    }

    return max_global;
}