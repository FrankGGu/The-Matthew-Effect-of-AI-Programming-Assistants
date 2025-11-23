#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool canJump(int* nums, int numsSize) {
    int reachable = 0;
    for (int i = 0; i < numsSize; i++) {
        if (i > reachable) {
            return false;
        }
        reachable = (reachable > i + nums[i]) ? reachable : i + nums[i];
    }
    return true;
}