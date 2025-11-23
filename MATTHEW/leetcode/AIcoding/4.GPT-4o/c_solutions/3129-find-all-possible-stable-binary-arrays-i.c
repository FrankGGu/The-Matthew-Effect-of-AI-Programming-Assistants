#include <stdio.h>
#include <stdlib.h>

int isStable(int *arr, int n) {
    for (int i = 0; i < n - 1; i++) {
        if (arr[i] == 1 && arr[i + 1] == 1) return 0;
    }
    return 1;
}

void backtrack(int *result, int *temp, int index, int n, int *returnSize) {
    if (index == n) {
        if (isStable(temp, n)) {
            for (int i = 0; i < n; i++) {
                result[*returnSize * n + i] = temp[i];
            }
            (*returnSize)++;
        }
        return;
    }

    temp[index] = 0;
    backtrack(result, temp, index + 1, n, returnSize);

    temp[index] = 1;
    backtrack(result, temp, index + 1, n, returnSize);
}

int** findStableArrays(int n, int* returnSize, int** returnColumnSizes) {
    int total = 1 << n;
    int *result = (int *)malloc(total * n * sizeof(int));
    int *temp = (int *)malloc(n * sizeof(int));
    *returnSize = 0;
    *returnColumnSizes = (int *)malloc(total * sizeof(int));

    backtrack(result, temp, 0, n, returnSize);

    for (int i = 0; i < *returnSize; i++) {
        (*returnColumnSizes)[i] = n;
    }

    int **stableArrays = (int **)malloc(*returnSize * sizeof(int *));
    for (int i = 0; i < *returnSize; i++) {
        stableArrays[i] = (int *)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            stableArrays[i][j] = result[i * n + j];
        }
    }

    free(result);
    free(temp);
    return stableArrays;
}