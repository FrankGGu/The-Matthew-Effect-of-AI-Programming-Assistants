#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void swap(int *a, int *b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

int compare(const void *a, const void *b) {
    return *(int*)a - *(int*)b;
}

void backtrack(int* nums, int numsSize, int start, int** result, int* returnSize, int** returnColumnSizes, int* current, int* used) {
    if (start == numsSize) {
        result[*returnSize] = (int*)malloc(sizeof(int) * numsSize);
        (*returnColumnSizes)[*returnSize] = numsSize;
        for (int i = 0; i < numsSize; i++) {
            result[*returnSize][i] = current[i];
        }
        (*returnSize)++;
        return;
    }

    for (int i = 0; i < numsSize; i++) {
        if (used[i] || (i > 0 && nums[i] == nums[i - 1] && !used[i - 1])) {
            continue;
        }
        used[i] = 1;
        current[start] = nums[i];
        backtrack(nums, numsSize, start + 1, result, returnSize, returnColumnSizes, current, used);
        used[i] = 0;
    }
}

int** permuteUnique(int* nums, int numsSize, int* returnSize, int** returnColumnSizes){
    qsort(nums, numsSize, sizeof(int), compare);

    int maxPermutations = 1;
    for (int i = 1; i <= numsSize; i++) {
        maxPermutations *= i;
    }

    int** result = (int**)malloc(sizeof(int*) * maxPermutations);
    *returnColumnSizes = (int*)malloc(sizeof(int) * maxPermutations);
    *returnSize = 0;

    int* current = (int*)malloc(sizeof(int) * numsSize);
    int* used = (int*)calloc(numsSize, sizeof(int));

    backtrack(nums, numsSize, 0, result, returnSize, returnColumnSizes, current, used);

    free(current);
    free(used);

    return result;
}