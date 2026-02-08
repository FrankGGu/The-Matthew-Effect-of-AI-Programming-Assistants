#include <stdlib.h>
#include <string.h>

static int compareIntegers(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

static void backtrack(int* candidates, int candidatesSize, int target, int startIdx,
                      int* currentPath, int pathLen,
                      int*** result, int** resultColSizes, int* resultSize, int* resultCapacity) {

    if (target == 0) {
        // Found a combination
        if (*resultSize == *resultCapacity) {
            *resultCapacity *= 2;
            *result = (int**)realloc(*result, (*resultCapacity) * sizeof(int*));
            *resultColSizes = (int*)realloc(*resultColSizes, (*resultCapacity) * sizeof(int));
        }
        (*result)[*resultSize] = (int*)malloc(pathLen * sizeof(int));
        memcpy((*result)[*resultSize], currentPath, pathLen * sizeof(int));
        (*resultColSizes)[*resultSize] = pathLen;
        (*resultSize)++;
        return;
    }

    if (target < 0) {
        return;
    }

    for (int i = startIdx; i < candidatesSize; i++) {
        // Skip duplicates: if the current number is the same as the previous one
        // and it's not the first element in the current level of recursion (i.e., i > startIdx),
        // then we've already considered combinations starting with this duplicate.
        if (i > startIdx && candidates[i] == candidates[i-1]) {
            continue;
        }

        // Optimization: if current candidate is greater than target,
        // no need to proceed further with this path or subsequent candidates
        // because the array is sorted and candidates are positive.
        if (candidates[i] > target) {
            break;
        }

        currentPath[pathLen] = candidates[i];
        backtrack(candidates, candidatesSize, target - candidates[i], i + 1,
                  currentPath, pathLen + 1,
                  result, resultColSizes, resultSize, resultCapacity);
        // Backtrack: no explicit removal from currentPath is needed as pathLen handles it
    }
}

int** combinationSum2(int* candidates, int candidatesSize, int target, int* returnSize, int** returnColumnSizes) {
    // Sort candidates to handle duplicates and for optimization
    qsort(candidates, candidatesSize, sizeof(int), compareIntegers);

    int initialCapacity = 32; // Initial capacity for result array
    int** result = (int**)malloc(initialCapacity * sizeof(int*));
    int* columnSizes = (int*)malloc(initialCapacity * sizeof(int));
    *returnSize = 0; // Number of combinations found

    // currentPath stores the combination being built. Max length is candidatesSize.
    int* currentPath = (int*)malloc(candidatesSize * sizeof(int));

    backtrack(candidates, candidatesSize, target, 0,
              currentPath, 0,
              &result, &columnSizes, returnSize, &initialCapacity);

    // Free the temporary currentPath
    free(currentPath);

    // Reallocate result and columnSizes to their actual final sizes
    *returnColumnSizes = (int*)realloc(columnSizes, (*returnSize) * sizeof(int));
    result = (int**)realloc(result, (*returnSize) * sizeof(int*));

    return result;
}