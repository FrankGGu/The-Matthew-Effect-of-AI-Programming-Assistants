#include <stdio.h>
#include <stdlib.h>

int* sortArrayByParityII(int* nums, int numsSize, int* returnSize) {
    *returnSize = numsSize;
    int i = 0, j = 1;
    while (i < numsSize && j < numsSize) {
        if (nums[i] % 2 == 0) {
            i += 2;
        } else if (nums[j] % 2 == 1) {
            j += 2;
        } else {
            int temp = nums[i];
            nums[i] = nums[j];
            nums[j] = temp;
            i += 2;
            j += 2;
        }
    }
    return nums;
}