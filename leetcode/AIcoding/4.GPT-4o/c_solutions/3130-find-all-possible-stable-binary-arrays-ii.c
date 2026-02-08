#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int isStable(int *array, int n) {
    for (int i = 1; i < n - 1; ++i) {
        if (array[i] == 1 && array[i-1] == 1 && array[i+1] == 1) {
            return 0;
        }
    }
    return 1;
}

void backtrack(int *current, int n, int index, int **result, int *returnSize) {
    if (index == n) {
        if (isStable(current, n)) {
            result[(*returnSize)] = (int *)malloc(n * sizeof(int));
            memcpy(result[(*returnSize)], current, n * sizeof(int));
            (*returnSize)++;
        }
        return;
    }
    current[index] = 0;
    backtrack(current, n, index + 1, result, returnSize);
    current[index] = 1;
    backtrack(current, n, index + 1, result, returnSize);
}

int **findStableArrays(int n, int *returnSize) {
    int **result = (int **)malloc(1 << n * sizeof(int *));
    *returnSize = 0;
    int *current = (int *)malloc(n * sizeof(int));
    backtrack(current, n, 0, result, returnSize);
    free(current);
    return result;
}