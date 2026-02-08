#include <stdio.h>
#include <stdlib.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int rob(int* nums, int numsSize) {
    if (numsSize == 0) return 0;
    if (numsSize == 1) return nums[0];
    if (numsSize == 2) return max(nums[0], nums[1]);

    int prev = max(nums[0], nums[1]);
    int curr = max(nums[1], nums[2]);

    for (int i = 3; i < numsSize; i++) {
        int temp = curr;
        curr = max(curr, prev + nums[i]);
        prev = temp;
    }

    return curr;
}