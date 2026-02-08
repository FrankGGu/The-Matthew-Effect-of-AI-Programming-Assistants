#include <stdio.h>
#include <stdlib.h>

int* sumZero(int n, int* returnSize) {
    int* result = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        result[i] = i - n / 2;
    }
    *returnSize = n;
    return result;
}