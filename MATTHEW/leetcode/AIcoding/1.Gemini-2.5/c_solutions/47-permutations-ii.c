#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

void backtrack(int* nums, int numsSize, int* currentPermutation, bool* used, int k,
               int*** result, int* resultSize, int** resultColSizes, int* resultCapacity) {
    if (k == numsSize) {
        if (*resultSize == *resultCapacity) {
            *resultCapacity *= 2;
            *result = (int**)realloc(*result, sizeof(int*) * (*resultCapacity));
            *resultColSizes = (int*)realloc(*resultColSizes, sizeof(int) * (*resultCapacity));
        }

        (*result)[*resultSize] = (int*)malloc(sizeof(int) * numsSize);
        memcpy((*result)[*resultSize], currentPermutation, sizeof(int) * numsSize);
        (*resultColSizes)[*resultSize] = numsSize;
        (*resultSize)++;
        return;
    }

    for (int i = 0; i < numsSize; i++) {
        if (used[i]) {
            continue;
        }

        if (i > 0 && nums[i] == nums[i-1] && !used[i-1]) {
            continue;
        }

        currentPermutation[k] = nums[i];
        used[i] = true;
        backtrack(nums, numsSize, currentPermutation, used, k + 1, result, resultSize, resultColSizes, resultCapacity);
        used[i] = false;
    }
}

int** permuteUnique(int* nums, int numsSize, int* returnSize, int** returnColumnSizes) {
    qsort(nums, numsSize, sizeof(int), compare);

    int initialCapacity = 10;
    int** result = (int**)malloc(sizeof(int*) * initialCapacity);
    *returnColumnSizes = (int*)malloc(sizeof(int) * initialCapacity);
    *returnSize = 0;
    int resultCapacity = initialCapacity;

    int* currentPermutation = (int*)malloc(sizeof(int) * numsSize);
    bool* used = (bool*)calloc(numsSize, sizeof(bool));

    backtrack(nums, numsSize, currentPermutation, used, 0, &result, returnSize, returnColumnSizes, &resultCapacity);

    free(currentPermutation);
    free(used);

    if (*returnSize < resultCapacity) {
        result = (int**)realloc(result, sizeof(int*) * (*returnSize));
        *returnColumnSizes = (int*)realloc(*returnColumnSizes, sizeof(int) * (*returnSize));
    }

    return result;
}