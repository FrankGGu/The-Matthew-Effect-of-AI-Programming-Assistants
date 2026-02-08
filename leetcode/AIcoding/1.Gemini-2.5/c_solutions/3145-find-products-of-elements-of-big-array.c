#include <stdlib.h>

int* productExceptSelf(int* nums, int numsSize, int* returnSize) {
    *returnSize = numsSize;
    int* result = (int*)malloc(sizeof(int) * numsSize);

    if (numsSize == 0) {
        return result;
    }

    result[0] = 1;
    for (int i = 1; i < numsSize; i++) {
        result[i] = result[i - 1] * nums[i - 1];
    }

    int right_product = 1;
    for (int i = numsSize - 1; i >= 0; i--) {
        result[i] = result[i] * right_product;
        right_product = right_product * nums[i];
    }

    return result;
}