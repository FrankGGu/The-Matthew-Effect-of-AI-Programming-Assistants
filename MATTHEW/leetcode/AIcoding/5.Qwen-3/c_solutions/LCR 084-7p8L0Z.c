#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void swap(char* a, char* b) {
    char t = *a;
    *a = *b;
    *b = t;
}

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

void backtrack(int* nums, int numsSize, int* used, int* path, int* returnSize, int** result, int depth) {
    if (depth == numsSize) {
        result[*returnSize] = (int*)malloc(numsSize * sizeof(int));
        memcpy(result[*returnSize], path, numsSize * sizeof(int));
        (*returnSize)++;
        return;
    }

    for (int i = 0; i < numsSize; i++) {
        if (used[i]) continue;
        if (i > 0 && nums[i] == nums[i - 1] && !used[i - 1]) continue;
        used[i] = 1;
        path[depth] = nums[i];
        backtrack(nums, numsSize, used, path, returnSize, result, depth + 1);
        used[i] = 0;
    }
}

int** permuteUnique(int* nums, int numsSize, int* returnSize, int** returnColumnSizes) {
    qsort(nums, numsSize, sizeof(int), compare);
    int** result = (int**)malloc(sizeof(int*) * 10000);
    *returnSize = 0;
    int* used = (int*)calloc(numsSize, sizeof(int));
    int* path = (int*)malloc(numsSize * sizeof(int));
    backtrack(nums, numsSize, used, path, returnSize, result, 0);
    *returnColumnSizes = (int*)malloc(*returnSize * sizeof(int));
    for (int i = 0; i < *returnSize; i++) {
        (*returnColumnSizes)[i] = numsSize;
    }
    free(used);
    free(path);
    return result;
}