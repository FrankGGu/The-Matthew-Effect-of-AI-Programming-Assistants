#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void backtrack(int* nums, int numsSize, int* path, int* used, int** result, int* resultSize, int depth) {
    if (depth == numsSize) {
        int* newPath = (int*)malloc(sizeof(int) * numsSize);
        for (int i = 0; i < numsSize; i++) {
            newPath[i] = path[i];
        }
        result[*resultSize] = newPath;
        (*resultSize)++;
        return;
    }

    for (int i = 0; i < numsSize; i++) {
        if (used[i] || (i > 0 && nums[i] == nums[i - 1] && !used[i - 1])) {
            continue;
        }
        path[depth] = nums[i];
        used[i] = 1;
        backtrack(nums, numsSize, path, used, result, resultSize, depth + 1);
        used[i] = 0;
    }
}

int compare(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

int** permuteUnique(int* nums, int numsSize, int* returnSize, int** returnColumnSizes) {
    qsort(nums, numsSize, sizeof(int), compare);

    int** result = (int**)malloc(sizeof(int*) * 1000);
    int* used = (int*)calloc(numsSize, sizeof(int));
    int* path = (int*)malloc(sizeof(int) * numsSize);
    *returnSize = 0;

    backtrack(nums, numsSize, path, used, result, returnSize, 0);

    *returnColumnSizes = (int*)malloc(sizeof(int) * (*returnSize));
    for (int i = 0; i < *returnSize; i++) {
        (*returnColumnSizes)[i] = numsSize;
    }

    free(used);
    free(path);

    return result;
}