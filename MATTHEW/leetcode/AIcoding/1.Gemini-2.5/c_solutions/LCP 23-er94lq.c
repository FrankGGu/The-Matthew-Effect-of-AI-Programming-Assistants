#include <stdlib.h>
#include <string.h>

void swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

int** result_global;
int result_size_global;
int* result_col_sizes_global;

void backtrack_permute(int* nums, int start, int numsSize) {
    if (start == numsSize) {
        result_global = (int**)realloc(result_global, (result_size_global + 1) * sizeof(int*));
        result_global[result_size_global] = (int*)malloc(numsSize * sizeof(int));
        memcpy(result_global[result_size_global], nums, numsSize * sizeof(int));

        result_col_sizes_global = (int*)realloc(result_col_sizes_global, (result_size_global + 1) * sizeof(int));
        result_col_sizes_global[result_size_global] = numsSize;
        result_size_global++;
        return;
    }

    for (int i = start; i < numsSize; i++) {
        swap(&nums[start], &nums[i]);
        backtrack_permute(nums, start + 1, numsSize);
        swap(&nums[start], &nums[i]);
    }
}

int** permute(int* nums, int numsSize, int* returnSize, int** returnColumnSizes) {
    result_global = NULL;
    result_size_global = 0;
    result_col_sizes_global = NULL;

    backtrack_permute(nums, 0, numsSize);

    *returnSize = result_size_global;
    *returnColumnSizes = result_col_sizes_global;

    return result_global;
}