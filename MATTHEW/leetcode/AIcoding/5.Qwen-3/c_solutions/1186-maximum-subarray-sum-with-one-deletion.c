#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int maxSubarraySum(int* nums, int numsSize) {
    int max_no_deletion = nums[0];
    int max_with_deletion = nums[0];
    int global_max = nums[0];

    for (int i = 1; i < numsSize; i++) {
        max_with_deletion = fmax(max_with_deletion + nums[i], max_no_deletion);
        max_no_deletion = fmax(max_no_deletion + nums[i], nums[i]);
        global_max = fmax(global_max, fmax(max_no_deletion, max_with_deletion));
    }

    return global_max;
}