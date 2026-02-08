#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int** createTargetArray(int* nums, int numsSize, int* targetIndices, int targetIndicesSize, int* returnSize, int** returnColumnSizes) {
    int** target = (int**)malloc(sizeof(int*) * numsSize);
    *returnColumnSizes = (int*)malloc(sizeof(int) * numsSize);
    *returnSize = 0;

    for (int i = 0; i < numsSize; i++) {
        int index = targetIndices[i];
        int val = nums[i];
        int* new_row = (int*)malloc(sizeof(int) * (*returnSize + 1));
        for (int j = 0; j < *returnSize; j++) {
            if (j == index) {
                new_row[j] = val;
            } else if (j < index) {
                new_row[j] = target[j][0];
            } else {
                new_row[j] = target[j - 1][0];
            }
        }
        if (index == *returnSize) {
            new_row[*returnSize] = val;
        }
        free(target[*returnSize]);
        target[*returnSize] = new_row;
        (*returnColumnSizes)[*returnSize] = *returnSize + 1;
        (*returnSize)++;
    }

    return target;
}