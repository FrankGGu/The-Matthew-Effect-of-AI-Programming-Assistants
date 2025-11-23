#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return *(int *)a - *(int *)b;
}

void combinationSum2Helper(int *candidates, int candidatesSize, int target, int *combination, int combinationSize, int **result, int *returnSize, int **returnColumnSizes, int start) {
    if (target == 0) {
        int *newCombination = (int *)malloc(sizeof(int) * combinationSize);
        for (int i = 0; i < combinationSize; i++) {
            newCombination[i] = combination[i];
        }
        result[*returnSize] = newCombination;
        (*returnColumnSizes)[*returnSize] = combinationSize;
        (*returnSize)++;
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
        combinationSum2Helper(candidates, candidatesSize, target - candidates[i], combination, combinationSize + 1, result, returnSize, returnColumnSizes, i + 1);
    }
}

int **combinationSum2(int *candidates, int candidatesSize, int target, int *returnSize, int **returnColumnSizes) {
    qsort(candidates, candidatesSize, sizeof(int), cmp);

    int **result = (int **)malloc(sizeof(int *) * 1000);
    *returnColumnSizes = (int *)malloc(sizeof(int) * 1000);
    *returnSize = 0;

    int *combination = (int *)malloc(sizeof(int) * candidatesSize);

    combinationSum2Helper(candidates, candidatesSize, target, combination, 0, result, returnSize, returnColumnSizes, 0);

    free(combination);

    return result;
}