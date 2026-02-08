#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* maximizeXor(int* nums, int numsSize, int maximumBit, int* returnSize){
    int max_xor = (1 << maximumBit) - 1;
    int* result = (int*)malloc(numsSize * sizeof(int));
    *returnSize = numsSize;
    int current_xor = 0;
    for (int i = 0; i < numsSize; i++) {
        current_xor ^= nums[i];
    }
    for (int i = 0; i < numsSize; i++) {
        result[i] = max_xor ^ current_xor;
        current_xor ^= nums[numsSize - 1 - i];
    }
    return result;
}