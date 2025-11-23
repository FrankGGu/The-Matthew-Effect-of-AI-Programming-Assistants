#include <stdio.h>
#include <stdlib.h>

void backtrack(int* candidates, int candidatesSize, int target, int start, int* path, int pathSize, int** result, int* returnSize) {
    if (target == 0) {
        result[*returnSize] = (int*)malloc((pathSize) * sizeof(int));
        for (int i = 0; i < pathSize; i++) {
            result[*returnSize][i] = path[i];
        }
        (*returnSize)++;
        return;
    }
    for (int i = start; i < candidatesSize; i++) {
        if (i > start && candidates[i] == candidates[i - 1]) continue;
        if (candidates[i] > target) break;
        path[pathSize] = candidates[i];
        backtrack(candidates, candidatesSize, target - candidates[i], i + 1, path, pathSize + 1, result, returnSize);
    }
}

int** combinationSum2(int* candidates, int candidatesSize, int target, int* returnSize, int** returnColumnSizes) {
    int** result = (int**)malloc(1000 * sizeof(int*));
    int* path = (int*)malloc(candidatesSize * sizeof(int));
    *returnSize = 0;
    backtrack(candidates, candidatesSize, target, 0, path, 0, result, returnSize);
    *returnColumnSizes = (int*)malloc((*returnSize) * sizeof(int));
    for (int i = 0; i < *returnSize; i++) {
        (*returnColumnSizes)[i] = sizeof(result[i]) / sizeof(result[i][0]);
    }
    free(path);
    return result;
}