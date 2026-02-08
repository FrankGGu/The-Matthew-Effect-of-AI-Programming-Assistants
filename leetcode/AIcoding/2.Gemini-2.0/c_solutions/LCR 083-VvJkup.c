#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void backtrack(int* nums, int numsSize, int* path, int* used, int** result, int* resultSize, int depth) {
    if (depth == numsSize) {
        int* temp = (int*)malloc(sizeof(int) * numsSize);
        for (int i = 0; i < numsSize; i++) {
            temp[i] = path[i];
        }
        result[*resultSize] = temp;
        (*resultSize)++;
        return;
    }

    for (int i = 0; i < numsSize; i++) {
        if (!used[i]) {
            path[depth] = nums[i];
            used[i] = 1;
            backtrack(nums, numsSize, path, used, result, resultSize, depth + 1);
            used[i] = 0;
        }
    }
}

int** permute(int* nums, int numsSize, int* returnSize, int** returnColumnSizes) {
    int factorial = 1;
    for (int i = 1; i <= numsSize; i++) {
        factorial *= i;
    }

    int** result = (int**)malloc(sizeof(int*) * factorial);
    int* path = (int*)malloc(sizeof(int) * numsSize);
    int* used = (int*)calloc(numsSize, sizeof(int));
    *returnSize = 0;

    backtrack(nums, numsSize, path, used, result, returnSize, 0);

    *returnColumnSizes = (int*)malloc(sizeof(int) * factorial);
    for (int i = 0; i < factorial; i++) {
        (*returnColumnSizes)[i] = numsSize;
    }

    free(path);
    free(used);

    return result;
}