#include <stdio.h>
#include <stdlib.h>

int** combinationSum(int* candidates, int candidatesSize, int target, int* returnSize, int** returnColumnSizes) {
    int** result = (int**)malloc(sizeof(int*) * 10000);
    *returnColumnSizes = (int*)malloc(sizeof(int) * 10000);
    *returnSize = 0;

    int* current = (int*)malloc(sizeof(int) * target);
    int currentSize = 0;

    void backtrack(int start, int sum) {
        if (sum == target) {
            int* copy = (int*)malloc(sizeof(int) * currentSize);
            for (int i = 0; i < currentSize; i++) {
                copy[i] = current[i];
            }
            result[*returnSize] = copy;
            (*returnColumnSizes)[*returnSize] = currentSize;
            (*returnSize)++;
            return;
        }
        if (sum > target) {
            return;
        }
        for (int i = start; i < candidatesSize; i++) {
            current[currentSize++] = candidates[i];
            backtrack(i, sum + candidates[i]);
            currentSize--;
        }
    }

    backtrack(0, 0);
    free(current);
    return result;
}