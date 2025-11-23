#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void moveZeroes(int* nums, int numsSize){
    int nonZeroIndex = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] != 0) {
            nums[nonZeroIndex] = nums[i];
            nonZeroIndex++;
        }
    }
    for (int i = nonZeroIndex; i < numsSize; i++) {
        nums[i] = 0;
    }
}