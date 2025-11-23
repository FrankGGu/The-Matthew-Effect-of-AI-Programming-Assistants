#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int* data;
    int size;
} Result;

void backtrack(int* arr, int n, int index, int prev1, int prev2, Result* result, int* returnSize, int** returnColumnSizes) {
    if (index == n) {
        int* copy = (int*)malloc(n * sizeof(int));
        memcpy(copy, arr, n * sizeof(int));
        result->data[*returnSize] = copy;
        (*returnSize)++;
        return;
    }

    if (index == 0 || (arr[index - 1] == 0 && prev1 == 0) || (arr[index - 1] == 1 && prev1 == 1)) {
        arr[index] = 0;
        backtrack(arr, n, index + 1, arr[index], prev1, result, returnSize, returnColumnSizes);
    }

    if (index == 0 || (arr[index - 1] == 0 && prev1 == 1) || (arr[index - 1] == 1 && prev1 == 0)) {
        arr[index] = 1;
        backtrack(arr, n, index + 1, arr[index], prev1, result, returnSize, returnColumnSizes);
    }
}

int** findStableBinaryArrays(int n, int* returnSize, int** returnColumnSizes) {
    int maxPossible = 1 << n;
    Result* result = (Result*)malloc(maxPossible * sizeof(Result));
    *returnSize = 0;
    int* arr = (int*)malloc(n * sizeof(int));
    backtrack(arr, n, 0, -1, -1, result, returnSize, returnColumnSizes);
    int** output = (int**)malloc(*returnSize * sizeof(int*));
    for (int i = 0; i < *returnSize; i++) {
        output[i] = result->data[i];
    }
    free(result);
    free(arr);
    return output;
}