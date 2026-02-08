#include <stdio.h>
#include <stdlib.h>

void backtrack(int* nums, int numsSize, int start, int* path, int pathSize, int*** res, int* returnSize, int* returnColumnSizes) {
    res[*returnSize] = (int**)malloc(sizeof(int*) * (pathSize + 1));
    for (int i = 0; i < pathSize; i++) {
        res[*returnSize][i] = (int*)malloc(sizeof(int) * pathSize);
        res[*returnSize][i][0] = path[i];
    }
    returnColumnSizes[*returnSize] = pathSize;
    (*returnSize)++;

    for (int i = start; i < numsSize; i++) {
        if (i > start && nums[i] == nums[i - 1]) continue;
        path[pathSize] = nums[i];
        backtrack(nums, numsSize, i + 1, path, pathSize + 1, res, returnSize, returnColumnSizes);
    }
}

int** subsetsWithDup(int* nums, int numsSize, int* returnSize, int** returnColumnSizes) {
    qsort(nums, numsSize, sizeof(int), cmp);
    int** res = (int**)malloc(sizeof(int*) * 10000);
    int* path = (int*)malloc(sizeof(int) * numsSize);
    *returnSize = 0;
    *returnColumnSizes = (int*)malloc(sizeof(int) * 10000);
    backtrack(nums, numsSize, 0, path, 0, &res, returnSize, *returnColumnSizes);
    free(path);
    return res;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}