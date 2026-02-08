#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minCost(int* nums, int numsSize) {
    int min1 = INT_MAX, min2 = INT_MAX;
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] < min1) {
            min2 = min1;
            min1 = nums[i];
        } else if (nums[i] < min2) {
            min2 = nums[i];
        }
    }
    return nums[0] + min1 + min2;
}