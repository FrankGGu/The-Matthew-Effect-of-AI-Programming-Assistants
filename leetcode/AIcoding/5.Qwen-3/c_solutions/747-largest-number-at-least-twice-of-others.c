#include <stdio.h>
#include <stdlib.h>

int dominantIndex(int* nums, int numsSize) {
    int max1 = -1, max2 = -1, index = -1;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > max1) {
            max2 = max1;
            max1 = nums[i];
            index = i;
        } else if (nums[i] > max2) {
            max2 = nums[i];
        }
    }
    return (max1 >= 2 * max2) ? index : -1;
}