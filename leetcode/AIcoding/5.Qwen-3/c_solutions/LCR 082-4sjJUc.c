#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int** combinationSum2(int* candidates, int candidatesSize, int target, int** returnSize, int** returnColumnSizes) {
    int** result = NULL;
    *returnSize = 0;
    *returnColumnSizes = NULL;

    int* path = (int*)malloc(sizeof(int) * candidatesSize);
    int pathLen = 0;

    qsort(candidates, candidatesSize, sizeof(int), (int (*)(const void*, const void*))strcmp);

    void backtrack(int start, int remain) {
        if (remain == 0) {
            int* temp = (int*)malloc(sizeof(int) * pathLen);
            memcpy(temp, path, sizeof(int) * pathLen);
            result = (int**)realloc(result, sizeof(int*) * (*returnSize + 1));
            result[*returnSize] = temp;
            (*returnSize)++;
            (*returnColumnSizes) = (int*)realloc(*returnColumnSizes, sizeof(int) * (*returnSize));
            (*returnColumnSizes)[*returnSize - 1] = pathLen;
            return;
        }

        for (int i = start; i < candidatesSize; i++) {
            if (i > start && candidates[i] == candidates[i - 1]) continue;
            if (candidates[i] > remain) break;
            path[pathLen++] = candidates[i];
            backtrack(i + 1, remain - candidates[i]);
            pathLen--;
        }
    }

    backtrack(0, target);
    free(path);
    return result;
}