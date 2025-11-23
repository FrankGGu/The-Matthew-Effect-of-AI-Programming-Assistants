#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxArrayValue(int* nums, int numsSize) {
    long long sum = nums[numsSize - 1];
    for (int i = numsSize - 2; i >= 0; i--) {
        if (nums[i] <= sum) {
            sum += nums[i];
        } else {
            sum = nums[i];
        }
    }
    return (int)sum;
}