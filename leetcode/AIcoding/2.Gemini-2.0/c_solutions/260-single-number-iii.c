#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* singleNumber(int* nums, int numsSize, int* returnSize){
    int xor = 0;
    for (int i = 0; i < numsSize; i++) {
        xor ^= nums[i];
    }

    int rightmostSetBit = xor & -xor;

    int num1 = 0;
    int num2 = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] & rightmostSetBit) {
            num1 ^= nums[i];
        } else {
            num2 ^= nums[i];
        }
    }

    int* result = (int*)malloc(2 * sizeof(int));
    result[0] = num1;
    result[1] = num2;
    *returnSize = 2;

    return result;
}