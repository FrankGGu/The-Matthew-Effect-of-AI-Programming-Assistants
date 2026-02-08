#include <stdio.h>
#include <stdlib.h>

int* missingRolls(int* rolls, int rollsSize, int mean, int n, int* returnSize) {
    int total = 0;
    for (int i = 0; i < rollsSize; i++) {
        total += rolls[i];
    }
    int m = rollsSize;
    int required = mean * (n + m) - total;
    if (required < n || required > 6 * n) {
        *returnSize = 0;
        return NULL;
    }
    int* result = (int*)malloc(n * sizeof(int));
    int avg = required / n;
    int rem = required % n;
    for (int i = 0; i < n; i++) {
        result[i] = avg + (i < rem ? 1 : 0);
    }
    *returnSize = n;
    return result;
}