#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int comp(const void *a, const void *b) {
    return *(int *)a - *(int *)b;
}

void backtrack(int *candidates, int candidatesSize, int target, int start, int *combination, int combinationSize, int **result, int *resultSize, int *columnSizes) {
    if (target == 0) {
        result[*resultSize] = (int *)malloc(sizeof(int) * combinationSize);
        for (int i = 0; i < combinationSize; i++) {
            result[*resultSize][i] = combination[i];
        }
        columnSizes[*resultSize] = combinationSize;
        (*resultSize)++;
        return;
    }

    if (target < 0) {
        return;
    }

    for (int i = start; i < candidatesSize; i++) {
        if (i > start && candidates[i] == candidates[i - 1]) {
            continue;
        }

        combination[combinationSize] = candidates[i];
        backtrack(candidates, candidatesSize, target - candidates[i], i + 1, combination, combinationSize + 1, result, resultSize, columnSizes);
    }
}

int** combinationSum2(int* candidates, int candidatesSize, int target, int* returnSize, int** returnColumnSizes){
    qsort(candidates, candidatesSize, sizeof(int), comp);

    int maxCombinations = 1000;
    int **result = (int **)malloc(sizeof(int *) * maxCombinations);
    int *columnSizes = (int *)malloc(sizeof(int) * maxCombinations);
    int *combination = (int *)malloc(sizeof(int) * candidatesSize);
    *returnSize = 0;

    backtrack(candidates, candidatesSize, target, 0, combination, 0, result, returnSize, columnSizes);

    free(combination);
    *returnColumnSizes = columnSizes;
    return result;
}