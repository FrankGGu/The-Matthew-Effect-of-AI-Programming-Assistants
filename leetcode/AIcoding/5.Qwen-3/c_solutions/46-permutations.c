#include <stdio.h>
#include <stdlib.h>

void swap(int* a, int* b) {
    int t = *a;
    *a = *b;
    *b = t;
}

void backtrack(int* nums, int start, int n, int** result, int* returnSize, int* returnColumnSizes) {
    if (start == n) {
        result[*returnSize] = (int*)malloc(n * sizeof(int));
        for (int i = 0; i < n; i++) {
            result[*returnSize][i] = nums[i];
        }
        returnColumnSizes[*returnSize] = n;
        (*returnSize)++;
        return;
    }

    for (int i = start; i < n; i++) {
        swap(&nums[start], &nums[i]);
        backtrack(nums, start + 1, n, result, returnSize, returnColumnSizes);
        swap(&nums[start], &nums[i]);
    }
}

int** permute(int* nums, int numsSize, int* returnSize, int** returnColumnSizes) {
    *returnSize = 0;
    int** result = (int**)malloc(sizeof(int*) * (factorial(numsSize)));
    *returnColumnSizes = (int*)malloc(sizeof(int) * (factorial(numsSize)));

    backtrack(nums, 0, numsSize, result, returnSize, *returnColumnSizes);

    return result;
}

int factorial(int n) {
    int result = 1;
    for (int i = 2; i <= n; i++) {
        result *= i;
    }
    return result;
}