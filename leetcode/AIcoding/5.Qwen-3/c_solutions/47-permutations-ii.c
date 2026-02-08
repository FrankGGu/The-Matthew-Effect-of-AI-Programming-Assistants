#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

void swap(int *a, int *b) {
    int t = *a;
    *a = *b;
    *b = t;
}

void backtrack(int *nums, int numsSize, int *used, int *current, int currentSize, int **result, int *returnSize, int **returnColumnSizes) {
    if (currentSize == numsSize) {
        result[*returnSize] = (int *)malloc(numsSize * sizeof(int));
        memcpy(result[*returnSize], current, numsSize * sizeof(int));
        (*returnSize)++;
        return;
    }

    for (int i = 0; i < numsSize; i++) {
        if (used[i]) continue;
        if (i > 0 && nums[i] == nums[i - 1] && !used[i - 1]) continue;
        used[i] = 1;
        current[currentSize] = nums[i];
        backtrack(nums, numsSize, used, current, currentSize + 1, result, returnSize, returnColumnSizes);
        used[i] = 0;
    }
}

int **permuteUnique(int *nums, int numsSize, int *returnSize, int **returnColumnSizes) {
    qsort(nums, numsSize, sizeof(int), compare);
    int **result = (int **)malloc(sizeof(int *) * 10000);
    *returnSize = 0;
    *returnColumnSizes = (int *)malloc(sizeof(int) * 10000);
    int *used = (int *)calloc(numsSize, sizeof(int));
    int *current = (int *)malloc(numsSize * sizeof(int));
    backtrack(nums, numsSize, used, current, 0, result, returnSize, returnColumnSizes);
    free(used);
    free(current);
    return result;
}