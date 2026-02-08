#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minMaxGame(int* nums, int numsSize){
    while (numsSize > 1) {
        int newNums[numsSize / 2];
        for (int i = 0; i < numsSize / 2; i++) {
            if (i % 2 == 0) {
                newNums[i] = (nums[2 * i] < nums[2 * i + 1]) ? nums[2 * i] : nums[2 * i + 1];
            } else {
                newNums[i] = (nums[2 * i] > nums[2 * i + 1]) ? nums[2 * i] : nums[2 * i + 1];
            }
        }
        for (int i = 0; i < numsSize / 2; i++) {
            nums[i] = newNums[i];
        }
        numsSize /= 2;
    }
    return nums[0];
}