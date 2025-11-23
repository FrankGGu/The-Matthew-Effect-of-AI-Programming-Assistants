#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool check(int* nums, int numsSize) {
    if (numsSize < 2) {
        return true;
    }

    for (int i = 0; i < numsSize - 1; i++) {
        if (nums[i] >= nums[i + 1]) {
            return false;
        }
    }

    return true;
}