#include <stdlib.h>
#include <string.h>

int compare(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

void backtrack(int* candidates, int candidatesSize, int target, int start,
               int* currentCombination, int currentCombinationSize,
               int*** result, int* resultSize, int** resultColSizes) {

    if (target == 0) {
        *resultColSizes = (int*)realloc(*resultColSizes, ((*resultSize) + 1) * sizeof(int));
        (*resultColSizes)[*resultSize] = currentCombinationSize;

        *result = (int**)realloc(*result, ((*resultSize) + 1) * sizeof(int*));
        (*result)[*resultSize] = (int*)malloc(currentCombinationSize * sizeof(int));
        memcpy((*result)[*resultSize], currentCombination, currentCombinationSize * sizeof(int));

        (*resultSize)++;
        return;
    }

    if (target < 0) {
        return;
    }

    for (int i = start; i < candidatesSize; i++) {
        if (i > start && candidates[i] == candidates[i-1]) {
            continue;
        }

        if (candidates[i] > target) {
            break;
        }

        currentCombination[currentCombinationSize] = candidates[i];
        backtrack(candidates, candidatesSize, target - candidates[i], i + 1,
                  currentCombination, currentCombinationSize + 1,
                  result, resultSize, resultColSizes);
    }
}

int** combinationSum2(int* candidates, int candidatesSize, int target, int* returnSize, int** returnColumnSizes) {
    qsort(candidates, candidatesSize, sizeof(int), compare);

    int** result = NULL;
    *returnSize = 0;
    *returnColumnSizes = NULL;

    int* currentCombination = (int*)malloc(candidatesSize * sizeof(int));

    backtrack(candidates, candidatesSize, target, 0,
              currentCombination, 0,
              &result, returnSize, returnColumnSizes);

    free(currentCombination);

    return result;
}