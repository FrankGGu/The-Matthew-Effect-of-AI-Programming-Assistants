#include <stdio.h>
#include <stdlib.h>

int maximumTop(int* nums, int numsSize, int k) {
    if (numsSize == 1) {
        return k % 2 == 0 ? nums[0] : -1;
    }
    if (k == 0) {
        return nums[0];
    }
    if (k >= numsSize) {
        return nums[numsSize - 1];
    }
    int max = nums[0];
    for (int i = 1; i <= k; i++) {
        if (i < numsSize && nums[i] > max) {
            max = nums[i];
        }
    }
    return max;
}