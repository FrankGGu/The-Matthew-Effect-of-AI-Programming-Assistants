#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findMaxK(int* nums, int numsSize) {
    int max_k = -1;
    bool seen[2001] = {false}; 

    for (int i = 0; i < numsSize; i++) {
        seen[nums[i] + 1000] = true;
    }

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > 0) {
            if (seen[-nums[i] + 1000]) {
                if (nums[i] > max_k) {
                    max_k = nums[i];
                }
            }
        }
    }

    return max_k;
}