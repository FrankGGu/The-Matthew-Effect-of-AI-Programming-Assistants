#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void backtrack(int* nums, int numsSize, int start, int** result, int* returnSize, int* returnColumnSizes, int* current, int* used) {
    if (start == numsSize) {
        result[*returnSize] = (int*)malloc(sizeof(int) * numsSize);
        returnColumnSizes[*returnSize] = numsSize;
        for (int i = 0; i < numsSize; i++) {
            result[*returnSize][i] = current[i];
        }
        (*returnSize)++;
        return;
    }

    for (int i = 0; i < numsSize; i++) {
        if (!used[i]) {
            current[start] = nums[i];
            used[i] = 1;
            backtrack(nums, numsSize, start + 1, result, returnSize, returnColumnSizes, current, used);
            used[i] = 0;
        }
    }
}

int** permute(int* nums, int numsSize, int* returnSize, int** returnColumnSizes) {
    int** result = (int**)malloc(sizeof(int*) * 5000);
    *returnColumnSizes = (int*)malloc(sizeof(int) * 5000);
    *returnSize = 0;
    int* current = (int*)malloc(sizeof(int) * numsSize);
    int* used = (int*)calloc(numsSize, sizeof(int));

    backtrack(nums, numsSize, 0, result, returnSize, *returnColumnSizes, current, used);

    free(current);
    free(used);
    return result;
}