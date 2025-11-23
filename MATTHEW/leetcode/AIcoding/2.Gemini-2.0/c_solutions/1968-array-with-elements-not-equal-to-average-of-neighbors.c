#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void swap(int *a, int *b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

int* rearrangeArray(int* nums, int numsSize, int* returnSize){
    *returnSize = numsSize;
    for (int i = 1; i < numsSize - 1; i++) {
        if ((nums[i - 1] + nums[i + 1]) / 2 == nums[i]) {
            swap(&nums[i], &nums[i + 1]);
        }
    }
    return nums;
}