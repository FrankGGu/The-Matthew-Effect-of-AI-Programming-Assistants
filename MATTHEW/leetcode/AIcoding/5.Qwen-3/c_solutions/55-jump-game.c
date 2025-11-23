#include <stdio.h>
#include <stdlib.h>

bool canJump(int* nums, int numsSize) {
    int max_reach = 0;
    for (int i = 0; i < numsSize; i++) {
        if (i > max_reach) return false;
        max_reach = (max_reach > i + nums[i]) ? max_reach : i + nums[i];
    }
    return true;
}