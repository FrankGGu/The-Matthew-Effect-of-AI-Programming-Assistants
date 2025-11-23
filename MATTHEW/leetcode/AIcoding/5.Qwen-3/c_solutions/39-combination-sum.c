#include <stdio.h>
#include <stdlib.h>

void backtrack(int* candidates, int candidatesSize, int target, int start, int* path, int pathSize, int*** result, int* returnSize, int** returnColumnSizes) {
    if (target == 0) {
        int* temp = (int*)malloc(pathSize * sizeof(int));
        for (int i = 0; i < pathSize; i++) {
            temp[i] = path[i];
        }
        (*result)[*returnSize] = temp;
        (*returnColumnSizes)[*returnSize] = pathSize;
        (*returnSize)++;
        return;
    }
    for (int i = start; i < candidatesSize; i++) {
        if (target - candidates[i] >= 0) {
            path[pathSize] = candidates[i];
            backtrack(candidates, candidatesSize, target - candidates[i], i, path, pathSize + 1, result, returnSize, returnColumnSizes);
        }
    }
}

int** combinationSum(int* candidates, int candidatesSize, int target, int* returnSize, int** returnColumnSizes) {
    *returnSize = 0;
    int** result = (int**)malloc(1000 * sizeof(int*));
    *returnColumnSizes = (int*)malloc(1000 * sizeof(int));
    int* path = (int*)malloc(1000 * sizeof(int));
    backtrack(candidates, candidatesSize, target, 0, path, 0, &result, returnSize, returnColumnSizes);
    free(path);
    return result;
}