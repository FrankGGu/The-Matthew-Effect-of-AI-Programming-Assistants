#include <stdio.h>
#include <stdlib.h>

int** combinationSum(int* candidates, int candidatesSize, int target, int* returnSize) {
    int** result = NULL;
    int* current = NULL;
    int currentSize = 0;
    int* count = NULL;

    void backtrack(int start, int remaining) {
        if (remaining == 0) {
            int* temp = (int*)malloc(currentSize * sizeof(int));
            for (int i = 0; i < currentSize; i++) {
                temp[i] = current[i];
            }
            result = (int**)realloc(result, (*returnSize + 1) * sizeof(int*));
            result[*returnSize] = temp;
            (*returnSize)++;
            return;
        }

        for (int i = start; i < candidatesSize; i++) {
            if (candidates[i] > remaining) continue;
            current = (int*)realloc(current, (currentSize + 1) * sizeof(int));
            current[currentSize++] = candidates[i];
            backtrack(i, remaining - candidates[i]);
            currentSize--;
        }
    }

    result = (int**)malloc(sizeof(int*));
    *returnSize = 0;
    current = (int*)malloc(0);
    backtrack(0, target);
    free(current);
    return result;
}