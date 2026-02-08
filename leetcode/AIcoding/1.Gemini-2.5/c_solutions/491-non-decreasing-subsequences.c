#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

void backtrack(int* nums, int numsSize, int index, int* currentSubsequence, int currentSize,
               int*** result, int** resultColSizes, int* returnSize, int* capacity) {

    if (currentSize >= 2) {
        if (*returnSize == *capacity) {
            *capacity *= 2;
            *result = (int**)realloc(*result, (*capacity) * sizeof(int*));
            *resultColSizes = (int*)realloc(*resultColSizes, (*capacity) * sizeof(int));
        }
        (*result)[*returnSize] = (int*)malloc(currentSize * sizeof(int));
        memcpy((*result)[*returnSize], currentSubsequence, currentSize * sizeof(int));
        (*resultColSizes)[*returnSize] = currentSize;
        (*returnSize)++;
    }

    bool used[201] = {false}; 

    for (int i = index; i < numsSize; ++i) {
        int val_idx = nums[i] + 100; 

        if (used[val_idx]) {
            continue;
        }

        if (currentSize == 0 || nums[i] >= currentSubsequence[currentSize - 1]) {
            used[val_idx] = true; 
            currentSubsequence[currentSize] = nums[i]; 
            backtrack(nums, numsSize, i + 1, currentSubsequence, currentSize + 1,
                      result, resultColSizes, returnSize, capacity);
        }
    }
}

int** findSubsequences(int* nums, int numsSize, int* returnSize, int** returnColumnSizes) {
    *returnSize = 0;

    if (numsSize < 2) {
        *returnColumnSizes = NULL;
        return NULL;
    }

    #define INITIAL_CAPACITY 1024 
    int current_capacity = INITIAL_CAPACITY;

    int** result = (int**)malloc(current_capacity * sizeof(int*));
    int* resultColSizes = (int*)malloc(current_capacity * sizeof(int));

    int* currentSubsequence = (int*)malloc(numsSize * sizeof(int));

    backtrack(nums, numsSize, 0, currentSubsequence, 0,
              &result, &resultColSizes, returnSize, &current_capacity);

    free(currentSubsequence);

    if (*returnSize == 0) {
        free(result);
        free(resultColSizes);
        *returnColumnSizes = NULL;
        return NULL;
    }

    result = (int**)realloc(result, (*returnSize) * sizeof(int*));
    resultColSizes = (int*)realloc(resultColSizes, (*returnSize) * sizeof(int));

    *returnColumnSizes = resultColSizes;

    return result;
}