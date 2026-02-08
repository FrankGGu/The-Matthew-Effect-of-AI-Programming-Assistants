#include <stdio.h>
#include <stdlib.h>

int* findProductsOfElements(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    if (!result) {
        *returnSize = 0;
        return NULL;
    }

    int leftProduct = 1;
    for (int i = 0; i < numsSize; i++) {
        result[i] = leftProduct;
        leftProduct *= nums[i];
    }

    int rightProduct = 1;
    for (int i = numsSize - 1; i >= 0; i--) {
        result[i] *= rightProduct;
        rightProduct *= nums[i];
    }

    *returnSize = numsSize;
    return result;
}