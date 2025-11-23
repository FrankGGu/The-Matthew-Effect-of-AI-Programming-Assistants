#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int* data;
    int size;
} Array;

void backtrack(int* nums, int numsSize, Array* current, int start, int** result, int* returnSize, int** returnColumnSizes) {
    if (current->size > 1) {
        result[*returnSize] = malloc(current->size * sizeof(int));
        for (int i = 0; i < current->size; i++) {
            result[*returnSize][i] = current->data[i];
        }
        returnColumnSizes[0][(*returnSize)++] = current->size;
    }

    for (int i = start; i < numsSize; i++) {
        if (current->size == 0 || current->data[current->size - 1] <= nums[i]) {
            current->data[current->size++] = nums[i];
            backtrack(nums, numsSize, current, i + 1, result, returnSize, returnColumnSizes);
            current->size--;
        }
    }
}

int** findSubsequences(int* nums, int numsSize, int* returnSize, int** returnColumnSizes) {
    int** result = malloc(1000 * sizeof(int*));
    *returnSize = 0;
    *returnColumnSizes = malloc(1000 * sizeof(int));
    Array current = { malloc(numsSize * sizeof(int)), 0 };

    backtrack(nums, numsSize, &current, 0, result, returnSize, returnColumnSizes);

    free(current.data);
    return result;
}