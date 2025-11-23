#include <stdio.h>
#include <stdlib.h>

void swap(int* a, int* b) {
    int t = *a;
    *a = *b;
    *b = t;
}

void backtrack(int* nums, int size, int start, int** result, int* returnSize, int* returnColumnSizes) {
    if (start == size) {
        result[*returnSize] = (int*)malloc(size * sizeof(int));
        for (int i = 0; i < size; i++) {
            result[*returnSize][i] = nums[i];
        }
        returnColumnSizes[*returnSize] = size;
        (*returnSize)++;
        return;
    }

    for (int i = start; i < size; i++) {
        swap(&nums[start], &nums[i]);
        backtrack(nums, size, start + 1, result, returnSize, returnColumnSizes);
        swap(&nums[start], &nums[i]);
    }
}

int** permute(int* nums, int numsSize, int* returnSize, int** returnColumnSizes) {
    *returnSize = 0;
    *returnColumnSizes = (int*)malloc(sizeof(int) * (int)pow(2, numsSize));
    int** result = (int**)malloc(sizeof(int*) * (int)pow(2, numsSize));

    backtrack(nums, numsSize, 0, result, returnSize, *returnColumnSizes);

    return result;
}