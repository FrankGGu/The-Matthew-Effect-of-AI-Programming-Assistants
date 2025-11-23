#include <stdio.h>
#include <stdlib.h>

void backtrack(int* nums, int numsSize, int** res, int* returnSize, int* path, int* used) {
    if (*returnSize == numsSize) {
        res[*returnSize] = (int*)malloc(sizeof(int) * numsSize);
        for (int i = 0; i < numsSize; i++) {
            res[*returnSize][i] = path[i];
        }
        (*returnSize)++;
        return;
    }
    for (int i = 0; i < numsSize; i++) {
        if (used[i]) continue;
        used[i] = 1;
        path[*returnSize] = nums[i];
        backtrack(nums, numsSize, res, returnSize, path, used);
        used[i] = 0;
    }
}

int** permute(int* nums, int numsSize, int* returnSize) {
    int** res = (int**)malloc(sizeof(int*) * 10000);
    *returnSize = 0;
    int* path = (int*)malloc(sizeof(int) * numsSize);
    int* used = (int*)calloc(numsSize, sizeof(int));
    backtrack(nums, numsSize, res, returnSize, path, used);
    free(path);
    free(used);
    return res;
}