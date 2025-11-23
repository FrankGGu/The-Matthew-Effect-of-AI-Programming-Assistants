#include <stdio.h>
#include <stdlib.h>

int* countBits(int n, int* returnSize) {
    int* result = (int*)malloc((n + 1) * sizeof(int));
    *returnSize = n + 1;
    for (int i = 0; i <= n; i++) {
        result[i] = __builtin_popcount(i);
    }
    return result;
}