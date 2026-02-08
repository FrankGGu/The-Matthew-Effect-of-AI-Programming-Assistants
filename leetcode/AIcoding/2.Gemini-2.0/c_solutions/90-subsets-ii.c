#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return *(int*)a - *(int*)b;
}

void backtrack(int* nums, int numsSize, int start, int* subset, int subsetSize, int** result, int* returnSize, int* columnSizes) {
    int* newSubset = (int*)malloc(sizeof(int) * subsetSize);
    for (int i = 0; i < subsetSize; i++) {
        newSubset[i] = subset[i];
    }

    result[*returnSize] = newSubset;
    columnSizes[*returnSize] = subsetSize;
    (*returnSize)++;

    for (int i = start; i < numsSize; i++) {
        if (i > start && nums[i] == nums[i - 1]) {
            continue;
        }
        subset[subsetSize] = nums[i];
        backtrack(nums, numsSize, i + 1, subset, subsetSize + 1, result, returnSize, columnSizes);
    }
}

int** subsetsWithDup(int* nums, int numsSize, int* returnSize, int** columnSizes) {
    qsort(nums, numsSize, sizeof(int), cmp);

    int maxSize = 1;
    for (int i = 0; i < numsSize; i++) {
        maxSize *= 2;
    }

    int** result = (int**)malloc(sizeof(int*) * maxSize);
    *columnSizes = (int*)malloc(sizeof(int) * maxSize);
    *returnSize = 0;

    int* subset = (int*)malloc(sizeof(int) * numsSize);

    backtrack(nums, numsSize, 0, subset, 0, result, returnSize, *columnSizes);

    free(subset);

    return result;
}