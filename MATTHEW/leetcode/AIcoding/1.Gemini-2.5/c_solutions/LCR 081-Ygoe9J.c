#include <stdlib.h> // For malloc, realloc, free, qsort
#include <string.h> // For memcpy

int compareInts(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

void backtrack(int* candidates, int candidatesSize, int target, int start, int currentSum,
               int** currentCombinationPtr, int* currentCombinationSizePtr, int* currentCombinationCapacityPtr,
               int*** resultPtr, int* resultSizePtr, int** returnColumnSizesPtr, int* resultCapacityPtr) {

    // Base case 1: Found a valid combination
    if (currentSum == target) {
        // Check if result array needs reallocation
        if (*resultSizePtr == *resultCapacityPtr) {
            *resultCapacityPtr *= 2;
            *resultPtr = (int**)realloc(*resultPtr, (*resultCapacityPtr) * sizeof(int*));
            *returnColumnSizesPtr = (int*)realloc(*returnColumnSizesPtr, (*resultCapacityPtr) * sizeof(int));
        }
        // Allocate memory for the new combination and copy elements
        (*resultPtr)[*resultSizePtr] = (int*)malloc((*currentCombinationSizePtr) * sizeof(int));
        memcpy((*resultPtr)[*resultSizePtr], *currentCombinationPtr, (*currentCombinationSizePtr) * sizeof(int));
        (*returnColumnSizesPtr)[*resultSizePtr] = *currentCombinationSizePtr;
        (*resultSizePtr)++;
        return;
    }

    // Base case 2: Current sum exceeds target
    if (currentSum > target) {
        return;
    }

    // Recursive step
    for (int i = start; i < candidatesSize; i++) {
        int candidate = candidates[i];

        // Optimization: If candidates are sorted, we can break early
        // if adding the current candidate exceeds target, subsequent candidates will also exceed target
        if (currentSum + candidate > target) {
            break;
        }

        // Check if currentCombination array needs reallocation
        if (*currentCombinationSizePtr == *currentCombinationCapacityPtr) {
            *currentCombinationCapacityPtr *= 2;
            *currentCombinationPtr = (int*)realloc(*currentCombinationPtr, (*currentCombinationCapacityPtr) * sizeof(int));
        }

        // Add candidate to current combination
        (*currentCombinationPtr)[*currentCombinationSizePtr] = candidate;
        (*currentCombinationSizePtr)++; // Increment the size directly through pointer

        // Recursive call (start from 'i' because same number can be chosen multiple times)
        backtrack(candidates, candidatesSize, target, i, currentSum + candidate,
                  currentCombinationPtr, currentCombinationSizePtr, currentCombinationCapacityPtr,
                  resultPtr, resultSizePtr, returnColumnSizesPtr, resultCapacityPtr);

        // Backtrack: remove candidate from current combination
        (*currentCombinationSizePtr)--; // Decrement the size directly through pointer
    }
}

int** combinationSum(int* candidates, int candidatesSize, int target, int* returnSize, int** returnColumnSizes) {
    // Sort candidates for optimization
    qsort(candidates, candidatesSize, sizeof(int), compareInts);

    // Initialize dynamic arrays for result
    int initialResultCapacity = 10;
    int** result = (int**)malloc(initialResultCapacity * sizeof(int*));
    *returnColumnSizes = (int*)malloc(initialResultCapacity * sizeof(int));
    int resultSize = 0;
    int resultCapacity = initialResultCapacity;

    // Initialize dynamic array for current combination
    int initialCombCapacity = 10;
    int* currentCombination = (int*)malloc(initialCombCapacity * sizeof(int));
    int currentCombinationSize = 0;
    int currentCombinationCapacity = initialCombCapacity;

    // Start backtracking
    backtrack(candidates, candidatesSize, target, 0, 0,
              &currentCombination, &currentCombinationSize, &currentCombinationCapacity,
              &result, &resultSize, returnColumnSizes, &resultCapacity);

    // Set the final return size
    *returnSize = resultSize;

    // Free the temporary currentCombination array
    free(currentCombination);

    // Shrink result and returnColumnSizes to actual size if necessary
    if (resultSize == 0) {
        free(result);
        free(*returnColumnSizes);
        result = NULL;
        *returnColumnSizes = NULL;
    } else if (resultSize < resultCapacity) {
        result = (int**)realloc(result, resultSize * sizeof(int*));
        *returnColumnSizes = (int*)realloc(*returnColumnSizes, resultSize * sizeof(int));
    }

    return result;
}