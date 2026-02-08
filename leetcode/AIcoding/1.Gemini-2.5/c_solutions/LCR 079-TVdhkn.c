#include <stdlib.h>
#include <string.h>

void backtrack(int* nums, int numsSize, int start, int* currentSubset, int currentSubsetSize,
               int** result, int* returnSize, int* returnColumnSizes) {

    result[*returnSize] = (int*)malloc(currentSubsetSize * sizeof(int));
    memcpy(result[*returnSize], currentSubset, currentSubsetSize * sizeof(int));
    returnColumnSizes[*returnSize] = currentSubsetSize;
    (*returnSize)++;

    for (int i = start; i < numsSize; i++) {
        currentSubset[currentSubsetSize] = nums[i];
        backtrack(nums, numsSize, i + 1, currentSubset, currentSubsetSize + 1,
                  result, returnSize, returnColumnSizes);
    }
}

int** subsets(int* nums, int numsSize, int* returnSize, int** returnColumnSizes) {
    int totalSubsets = 1;
    for (int i = 0; i < numsSize; i++) {
        totalSubsets *= 2;
    }

    int** result = (int**)malloc(totalSubsets * sizeof(int*));
    *returnColumnSizes = (int*)malloc(totalSubsets * sizeof(int));
    *returnSize = 0;

    int* currentSubset = (int*)malloc(numsSize * sizeof(int));

    backtrack(nums, numsSize, 0, currentSubset, 0,
              result, returnSize, *returnColumnSizes);

    free(currentSubset);

    return result;
}