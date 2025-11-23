#include <stdio.h>
#include <stdlib.h>

int maxRotateValue(int* nums, int numsSize) {
    int sum = 0;
    int f = 0;
    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
        f += i * nums[i];
    }

    int max = f;
    for (int i = numsSize - 1; i > 0; i--) {
        f = f + sum - nums[i] * numsSize;
        if (f > max) {
            max = f;
        }
    }
    return max;
}