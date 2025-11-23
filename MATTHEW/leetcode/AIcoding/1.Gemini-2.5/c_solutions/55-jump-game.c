#include <stdbool.h>

bool canJump(int* nums, int numsSize) {
    int reachable = 0;
    for (int i = 0; i < numsSize; i++) {
        if (i > reachable) {
            return false;
        }
        if (i + nums[i] > reachable) {
            reachable = i + nums[i];
        }
        if (reachable >= numsSize - 1) {
            return true;
        }
    }
    return true;
}