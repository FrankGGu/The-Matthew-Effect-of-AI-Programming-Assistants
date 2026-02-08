#include <stdio.h>
#include <stdlib.h>

int numSubarrayBounded(int* nums, int numsSize, int left, int right) {
    int count = 0;
    int prev = 0;
    int res = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] < left) {
            res += prev;
        } else if (nums[i] > right) {
            prev = 0;
        } else {
            prev = i - 1 >= 0 ? prev + 1 : 1;
            res += prev;
        }
    }
    return res;
}

int numSubarraysWithBound(int* nums, int numsSize, int left, int right) {
    return numSubarrayBounded(nums, numsSize, left, right);
}