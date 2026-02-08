#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* createTargetArray(int* nums, int numsSize, int* index, int indexSize, int* returnSize){
    int *target = (int*)malloc(sizeof(int) * numsSize);
    *returnSize = numsSize;
    for (int i = 0; i < numsSize; i++) {
        for (int j = numsSize - 1; j > index[i]; j--) {
            target[j] = target[j - 1];
        }
        target[index[i]] = nums[i];
    }
    return target;
}