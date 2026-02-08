#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void backtrack(int* candidates, int candidatesSize, int target, int start, int* path, int pathLen, int*** result, int* returnSize, int** returnColumnSizes) {
    if (target == 0) {
        int* temp = (int*)malloc(pathLen * sizeof(int));
        memcpy(temp, path, pathLen * sizeof(int));
        (*result)[*returnSize] = temp;
        (*returnColumnSizes)[*returnSize] = pathLen;
        (*returnSize)++;
        return;
    }
    for (int i = start; i < candidatesSize && target >= candidates[i]; i++) {
        if (i > start && candidates[i] == candidates[i - 1]) continue;
        path[pathLen] = candidates[i];
        backtrack(candidates, candidatesSize, target - candidates[i], i + 1, path, pathLen + 1, result, returnSize, returnColumnSizes);
    }
}

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int** combinationSum2(int* candidates, int candidatesSize, int target, int* returnSize, int** returnColumnSizes) {
    qsort(candidates, candidatesSize, sizeof(int), compare);
    int** result = (int**)malloc(1000 * sizeof(int*));
    *returnSize = 0;
    *returnColumnSizes = (int*)malloc(1000 * sizeof(int));
    int* path = (int*)malloc(candidatesSize * sizeof(int));
    backtrack(candidates, candidatesSize, target, 0, path, 0, &result, returnSize, returnColumnSizes);
    free(path);
    return result;
}