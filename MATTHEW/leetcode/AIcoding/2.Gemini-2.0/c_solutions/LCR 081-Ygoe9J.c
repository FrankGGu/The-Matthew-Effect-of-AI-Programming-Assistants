#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void backtrack(int *candidates, int candidatesSize, int target, int *combination, int combinationSize, int start, int **result, int *returnSize, int *returnColumnSizes) {
    if (target == 0) {
        result[*returnSize] = (int *)malloc(sizeof(int) * combinationSize);
        for (int i = 0; i < combinationSize; i++) {
            result[*returnSize][i] = combination[i];
        }
        returnColumnSizes[*returnSize] = combinationSize;
        (*returnSize)++;
        return;
    }

    if (target < 0) {
        return;
    }

    for (int i = start; i < candidatesSize; i++) {
        combination[combinationSize] = candidates[i];
        backtrack(candidates, candidatesSize, target - candidates[i], combination, combinationSize + 1, i, result, returnSize, returnColumnSizes);
    }
}

int **combinationSum(int *candidates, int candidatesSize, int target, int *returnSize, int **returnColumnSizes) {
    int **result = (int **)malloc(sizeof(int *) * 10000);
    *returnColumnSizes = (int *)malloc(sizeof(int) * 10000);
    *returnSize = 0;
    int *combination = (int *)malloc(sizeof(int) * 10000);

    backtrack(candidates, candidatesSize, target, combination, 0, 0, result, returnSize, *returnColumnSizes);

    free(combination);
    return result;
}