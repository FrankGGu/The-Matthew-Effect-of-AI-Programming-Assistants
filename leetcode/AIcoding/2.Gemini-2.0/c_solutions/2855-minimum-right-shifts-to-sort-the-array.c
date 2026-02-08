#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumRightShifts(int* nums, int numsSize) {
    int shifts = 0;
    for (int i = 0; i < numsSize - 1; i++) {
        if (nums[i] > nums[i + 1]) {
            shifts++;
        }
    }

    if (shifts == 0) {
        return 0;
    }

    if (shifts > 1) {
        return -1;
    }

    if (nums[numsSize - 1] > nums[0]) {
        return -1;
    }

    int ans = numsSize - 1;
    for(int i = 0; i < numsSize - 1; ++i){
        if(nums[i] > nums[i+1]){
            ans = i + 1;
            break;
        }
    }

    return numsSize - ans;
}