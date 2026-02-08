#include <stdio.h>
#include <stdlib.h>

int maxSubsequenceSum(int* nums, int numsSize) {
    if (numsSize == 0) return 0;
    if (numsSize == 1) return nums[0];

    int prevPrev = nums[0];
    int prev = (nums[0] > nums[1]) ? nums[0] : nums[1];

    for (int i = 2; i < numsSize; i++) {
        int current = (prevPrev + nums[i] > prev) ? (prevPrev + nums[i]) : prev;
        prevPrev = prev;
        prev = current;
    }

    return prev;
}