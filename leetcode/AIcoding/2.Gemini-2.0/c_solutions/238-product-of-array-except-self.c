#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* productExceptSelf(int* nums, int numsSize, int* returnSize){
    int *result = (int*)malloc(numsSize * sizeof(int));
    *returnSize = numsSize;

    result[0] = 1;
    for (int i = 1; i < numsSize; i++) {
        result[i] = result[i - 1] * nums[i - 1];
    }

    int rightProduct = 1;
    for (int i = numsSize - 1; i >= 0; i--) {
        result[i] = result[i] * rightProduct;
        rightProduct = rightProduct * nums[i];
    }

    return result;
}