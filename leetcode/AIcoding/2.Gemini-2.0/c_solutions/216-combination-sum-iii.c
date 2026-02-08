#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void combinationSum3Helper(int k, int n, int start, int *combination, int combinationSize, int **result, int *returnSize) {
    if (n == 0 && combinationSize == k) {
        int *newCombination = (int *)malloc(sizeof(int) * k);
        for (int i = 0; i < k; i++) {
            newCombination[i] = combination[i];
        }
        result[*returnSize] = newCombination;
        (*returnSize)++;
        return;
    }

    if (n < 0 || combinationSize > k) {
        return;
    }

    for (int i = start; i <= 9; i++) {
        combination[combinationSize] = i;
        combinationSum3Helper(k, n - i, i + 1, combination, combinationSize + 1, result, returnSize);
    }
}

int** combinationSum3(int k, int n, int* returnSize) {
    int **result = (int **)malloc(sizeof(int *) * 500);
    int *combination = (int *)malloc(sizeof(int) * k);
    *returnSize = 0;
    combinationSum3Helper(k, n, 1, combination, 0, result, returnSize);
    free(combination);
    return result;
}