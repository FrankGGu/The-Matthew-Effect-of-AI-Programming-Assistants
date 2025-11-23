#include <stdio.h>
#include <stdlib.h>

int* createTargetArray(int* nums, int numsSize, int* index, int indexSize, int* returnSize) {
    int* target = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        int pos = index[i];
        for (int j = numsSize - 1; j > pos; j--) {
            target[j] = target[j - 1];
        }
        target[pos] = nums[i];
    }
    *returnSize = numsSize;
    return target;
}