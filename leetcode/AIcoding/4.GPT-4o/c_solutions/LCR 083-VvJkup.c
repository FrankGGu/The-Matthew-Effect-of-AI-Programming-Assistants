#include <stdio.h>
#include <stdlib.h>

void backtrack(int* nums, int numsSize, int** res, int* returnSize, int* path, int* used) {
    if (*returnSize == 0) {
        res[0] = (int*)malloc(sizeof(int) * numsSize);
        for (int i = 0; i < numsSize; i++) {
            res[0][i] = path[i];
        }
        (*returnSize)++;
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
    *returnSize = 0;
    int** res = (int**)malloc(sizeof(int*) * 10000);
    int* path = (int*)malloc(sizeof(int) * numsSize);
    int* used = (int*)calloc(numsSize, sizeof(int));

    backtrack(nums, numsSize, res, returnSize, path, used);

    free(path);
    free(used);
    return res;
}