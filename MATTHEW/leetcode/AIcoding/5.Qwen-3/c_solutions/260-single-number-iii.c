#include <stdio.h>
#include <stdlib.h>

int* singleNumber(int* nums, int numsSize, int* returnSize) {
    int xorAll = 0;
    for (int i = 0; i < numsSize; i++) {
        xorAll ^= nums[i];
    }

    int diff = xorAll & (-xorAll);

    int num1 = 0, num2 = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] & diff) {
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