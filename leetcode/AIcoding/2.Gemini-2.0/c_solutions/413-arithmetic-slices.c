#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numberOfArithmeticSlices(int* nums, int numsSize) {
    if (numsSize < 3) return 0;
    int dp = 0;
    int sum = 0;
    for (int i = 2; i < numsSize; i++) {
        if (nums[i] - nums[i - 1] == nums[i - 1] - nums[i - 2]) {
            dp = dp + 1;
            sum = sum + dp;
        } else {
            dp = 0;
        }
    }
    return sum;
}