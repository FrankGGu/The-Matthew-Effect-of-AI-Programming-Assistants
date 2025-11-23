#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void swap(int *a, int *b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

int* sortArrayByParityII(int* nums, int numsSize, int* returnSize){
    *returnSize = numsSize;
    int even = 0, odd = 1;
    while (even < numsSize && odd < numsSize) {
        while (even < numsSize && nums[even] % 2 == 0) {
            even += 2;
        }
        while (odd < numsSize && nums[odd] % 2 != 0) {
            odd += 2;
        }
        if (even < numsSize && odd < numsSize) {
            swap(&nums[even], &nums[odd]);
        }
    }
    return nums;
}