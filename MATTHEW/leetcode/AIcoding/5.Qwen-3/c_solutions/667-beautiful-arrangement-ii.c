#include <stdio.h>
#include <stdlib.h>

int* constructArray(int n, int k, int* returnSize) {
    int* result = (int*)malloc(n * sizeof(int));
    int i, j;
    for (i = 0; i <= k; i++) {
        result[i] = i + 1;
    }
    for (i = k + 1; i < n; i++) {
        result[i] = result[i - k - 1] - 1;
    }
    *returnSize = n;
    return result;
}