#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void combinationSumHelper(int* candidates, int candidatesSize, int target, int* combination, int combinationSize, int** result, int* returnSize, int** returnColumnSizes, int start) {
    if (target == 0) {
        (*returnColumnSizes)[*returnSize] = combinationSize;
        result[*returnSize] = (int*)malloc(sizeof(int) * combinationSize);
        for (int i = 0; i < combinationSize; i++) {
            result[*returnSize][i] = combination[i];
        }
        (*returnSize)++;
        return;
    }

    if (target < 0) {
        return;
    }

    for (int i = start; i < candidatesSize; i++) {
        combination[combinationSize] = candidates[i];
        combinationSumHelper(candidates, candidatesSize, target - candidates[i], combination, combinationSize + 1, result, returnSize, returnColumnSizes, i);
    }
}

int** combinationSum(int* candidates, int candidatesSize, int target, int* returnSize, int** returnColumnSizes) {
    int** result = (int**)malloc(sizeof(int*) * 10000);
    *returnColumnSizes = (int*)malloc(sizeof(int) * 10000);
    *returnSize = 0;
    int* combination = (int*)malloc(sizeof(int) * 200);
    combinationSumHelper(candidates, candidatesSize, target, combination, 0, result, returnSize, returnColumnSizes, 0);
    free(combination);
    return result;
}