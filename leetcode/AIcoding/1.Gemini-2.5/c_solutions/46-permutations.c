#include <stdlib.h>
#include <string.h>

void backtrack(int* nums, int numsSize, int* currentPermutation, int currentSize, int* used, int** result, int* returnSize, int** returnColumnSizes) {
    if (currentSize == numsSize) {
        result[*returnSize] = (int*)malloc(sizeof(int) * numsSize);
        memcpy(result[*returnSize], currentPermutation, sizeof(int) * numsSize);
        (*returnColumnSizes)[*returnSize] = numsSize;
        (*returnSize)++;
        return;
    }

    for (int i = 0; i < numsSize; i++) {
        if (!used[i]) {
            used[i] = 1;
            currentPermutation[currentSize] = nums[i];
            backtrack(nums, numsSize, currentPermutation, currentSize + 1, used, result, returnSize, returnColumnSizes);
            used[i] = 0;
        }
    }
}

int** permute(int* nums, int numsSize, int* returnSize, int** returnColumnSizes) {
    int max_permutations = 1;
    for (int i = 1; i <= numsSize; i++) {
        max_permutations *= i;
    }

    int** result = (int**)malloc(sizeof(int*) * max_permutations);
    *returnColumnSizes = (int*)malloc(sizeof(int) * max_permutations);
    *returnSize = 0;

    int* currentPermutation = (int*)malloc(sizeof(int) * numsSize);
    int* used = (int*)calloc(numsSize, sizeof(int)); 

    backtrack(nums, numsSize, currentPermutation, 0, used, result, returnSize, returnColumnSizes);

    free(currentPermutation);
    free(used);

    return result;
}