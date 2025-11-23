#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool canMakeSubarraySumsZero(int* nums, int numsSize, int k) {
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] < 0) {
            nums[i] = (nums[i] % k + k) % k;
        } else {
            nums[i] %= k;
        }
    }

    for (int i = 1; i < numsSize; i++) {
        if (nums[i] != nums[0]) {
            return false;
        }
    }

    return true;
}