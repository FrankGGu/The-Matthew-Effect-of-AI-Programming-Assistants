#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int jump(int* nums, int numsSize) {
    if (numsSize <= 1) {
        return 0;
    }

    int jumps = 0;
    int current_reach = 0;
    int max_reach = 0;

    for (int i = 0; i < numsSize - 1; i++) {
        max_reach = (max_reach > i + nums[i]) ? max_reach : i + nums[i];

        if (i == current_reach) {
            jumps++;
            current_reach = max_reach;

            if (current_reach >= numsSize - 1) {
                return jumps;
            }
             if (current_reach <= i) return -1;
        }
    }

    return jumps;
}