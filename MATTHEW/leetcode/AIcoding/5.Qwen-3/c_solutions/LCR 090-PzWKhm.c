#include <stdio.h>
#include <stdlib.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int robHelper(int* nums, int start, int end) {
    int prev = 0, curr = 0;
    for (int i = start; i <= end; i++) {
        int temp = curr;
        curr = max(curr, prev + nums[i]);
        prev = temp;
    }
    return curr;
}

int rob(int* nums, int numsSize) {
    if (numsSize == 1) return nums[0];
    if (numsSize == 2) return max(nums[0], nums[1]);
    return max(robHelper(nums, 0, numsSize - 2), robHelper(nums, 1, numsSize - 1));
}