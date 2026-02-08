#include <stdlib.h>
#include <string.h>

void backtrack(int* candidates, int candidatesSize, int target, int currentSum, int startIndex,
               int* currentCombination, int currentCombinationSize,
               int*** result, int* resultSize, int** columnSizes, int* resultCapacity) {

    if (currentSum == target) {
        // Found a valid combination
        if (*resultSize == *resultCapacity) {
            *resultCapacity *= 2;
            *result = (int**)realloc(*result, (*resultCapacity) * sizeof(int*));
            *columnSizes = (int*)realloc(*columnSizes, (*resultCapacity) * sizeof(int));
        }

        (*result)[*resultSize] = (int*)malloc(currentCombinationSize * sizeof(int));
        for (int i = 0; i < currentCombinationSize; i++) {
            (*result)[*resultSize][i] = currentCombination[i];
        }
        (*columnSizes)[*resultSize] = currentCombinationSize;
        (*resultSize)++;
        return;
    }

    if (currentSum > target) {
        return;
    }

    // Explore further
    for (int i = startIndex; i < candidatesSize; i++) {
        currentCombination[currentCombinationSize] = candidates[i];
        backtrack(candidates, candidatesSize, target,
                   currentSum + candidates[i], i, // Use 'i' to allow reusing the same number
                   currentCombination, currentCombinationSize + 1,
                   result, resultSize, columnSizes, resultCapacity);
    }
}

int** combinationSum(int* candidates, int candidatesSize, int target, int* returnSize, int** returnColumnSizes) {
    *returnSize = 0;
    int initialCapacity = 10; 
    int** result = (int**)malloc(initialCapacity * sizeof(int*));
    int* columnSizes = (int*)malloc(initialCapacity * sizeof(int));
    int currentResultCapacity = initialCapacity;

    // Max possible combination length is target (e.g., if candidate is 1 and target is 500, length is 500)
    int* currentCombination = (int*)malloc((target + 1) * sizeof(int)); 

    backtrack(candidates, candidatesSize, target,
               0, 0, // currentSum, startIndex
               currentCombination, 0, // currentCombination, currentCombinationSize
               &result, returnSize, &columnSizes, &currentResultCapacity);

    free(currentCombination);

    // Trim the allocated memory to the actual size
    if (*returnSize == 0) {
        free(result);
        free(columnSizes);
        *returnColumnSizes = NULL;
        return NULL;
    }

    *returnColumnSizes = (int*)realloc(columnSizes, (*returnSize) * sizeof(int));
    result = (int**)realloc(result, (*returnSize) * sizeof(int*));

    *returnColumnSizes = columnSizes;
    return result;
}