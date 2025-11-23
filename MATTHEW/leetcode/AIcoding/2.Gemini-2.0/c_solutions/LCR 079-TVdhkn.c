#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void backtrack(int* nums, int numsSize, int index, int* subset, int subsetSize, int** result, int* returnSize, int** returnColumnSizes) {
    result[*returnSize] = (int*)malloc(sizeof(int) * subsetSize);
    for (int i = 0; i < subsetSize; i++) {
        result[*returnSize][i] = subset[i];
    }
    (*returnColumnSizes)[*returnSize] = subsetSize;
    (*returnSize)++;

    for (int i = index; i < numsSize; i++) {
        subset[subsetSize] = nums[i];
        backtrack(nums, numsSize, i + 1, subset, subsetSize + 1, result, returnSize, returnColumnSizes);
    }
}

int** subsets(int* nums, int numsSize, int* returnSize, int** returnColumnSizes) {
    int maxSize = 1 << numsSize;
    int** result = (int**)malloc(sizeof(int*) * maxSize);
    *returnColumnSizes = (int*)malloc(sizeof(int) * maxSize);
    *returnSize = 0;
    int* subset = (int*)malloc(sizeof(int) * numsSize);

    backtrack(nums, numsSize, 0, subset, 0, result, returnSize, returnColumnSizes);

    free(subset);
    return result;
}