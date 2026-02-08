#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int maxSubarraySum(int* nums, int numsSize) {
    int max_current = nums[0];
    int max_global = nums[0];
    for (int i = 1; i < numsSize; i++) {
        max_current = (max_current + nums[i] > nums[i]) ? max_current + nums[i] : nums[i];
        if (max_current > max_global) {
            max_global = max_current;
        }
    }
    return max_global;
}

int minSubarraySum(int* nums, int numsSize) {
    int min_current = nums[0];
    int min_global = nums[0];
    for (int i = 1; i < numsSize; i++) {
        min_current = (min_current + nums[i] < nums[i]) ? min_current + nums[i] : nums[i];
        if (min_current < min_global) {
            min_global = min_current;
        }
    }
    return min_global;
}

int maxCircularSubarraySum(int* nums, int numsSize) {
    int max_normal = maxSubarraySum(nums, numsSize);
    if (max_normal < 0) {
        return max_normal;
    }
    int max_circular = 0;
    for (int i = 0; i < numsSize; i++) {
        max_circular += nums[i];
    }
    int min_subarray = minSubarraySum(nums, numsSize);
    max_circular = max_circular - min_subarray;
    return (max_circular > max_normal) ? max_circular : max_normal;
}