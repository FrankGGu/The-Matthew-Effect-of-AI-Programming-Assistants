#include <stdio.h>
#include <stdlib.h>

int smallestRangeI(int* nums, int numsSize, int k) {
    int min = nums[0];
    int max = nums[0];
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] < min) min = nums[i];
        if (nums[i] > max) max = nums[i];
    }
    return (max - min) > k ? (max - min - k) : 0;
}