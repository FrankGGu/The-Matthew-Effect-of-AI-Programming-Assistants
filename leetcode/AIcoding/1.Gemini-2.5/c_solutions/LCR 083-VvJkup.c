#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

void backtrack(int* nums, int numsSize, int* currentPermutation, int currentSize, bool* used,
               int*** result, int* resultCapacity, int* resultSize, int** resultColumnSizes) {
    if (currentSize == numsSize) {
        if (*resultSize == *resultCapacity) {
            *resultCapacity *= 2;
            *result = (int**)realloc(*result, (*resultCapacity) * sizeof(int*));
            *resultColumnSizes = (int*)realloc(*resultColumnSizes, (*resultCapacity) * sizeof(int));
        }

        (*result)[*resultSize] = (int*)malloc(numsSize * sizeof(int));
        memcpy((*result)[*resultSize], currentPermutation, numsSize * sizeof(int));
        (*resultColumnSizes)[*resultSize] = numsSize;
        (*resultSize)++;
        return;
    }

    for (int i = 0; i < numsSize; i++) {
        if (!used[i]) {
            used[i] = true;
            currentPermutation[currentSize] = nums[i];

            backtrack(nums, numsSize, currentPermutation, currentSize + 1, used,
                      result, resultCapacity, resultSize, resultColumnSizes);

            used[i] = false;
        }
    }
}

int** permute(int* nums, int numsSize, int* returnSize, int** returnColumnSizes) {
    int** result = NULL;
    int resultCapacity = 1;
    int currentResultSize = 0;

    result = (int**)malloc(resultCapacity * sizeof(int*));
    *returnColumnSizes = (int*)malloc(resultCapacity * sizeof(int));

    int* currentPermutation = (int*)malloc(numsSize * sizeof(int));
    bool* used = (bool*)calloc(numsSize, sizeof(bool));

    backtrack(nums, numsSize, currentPermutation, 0, used,
              &result, &resultCapacity, &currentResultSize, returnColumnSizes);

    free(currentPermutation);
    free(used);

    *returnSize = currentResultSize;

    result = (int**)realloc(result, currentResultSize * sizeof(int*));
    *returnColumnSizes = (int*)realloc(*returnColumnSizes, currentResultSize * sizeof(int));

    return result;
}