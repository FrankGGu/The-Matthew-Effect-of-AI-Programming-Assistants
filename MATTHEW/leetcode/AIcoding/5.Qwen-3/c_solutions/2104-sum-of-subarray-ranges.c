#include <stdio.h>
#include <stdlib.h>

long long sumSubarrayRanges(int* nums, int numsSize) {
    long long result = 0;
    for (int i = 0; i < numsSize; i++) {
        int min_val = nums[i];
        int max_val = nums[i];
        for (int j = i + 1; j < numsSize; j++) {
            min_val = (nums[j] < min_val) ? nums[j] : min_val;
            max_val = (nums[j] > max_val) ? nums[j] : max_val;
            result += (long long)(max_val - min_val);
        }
    }
    return result;
}