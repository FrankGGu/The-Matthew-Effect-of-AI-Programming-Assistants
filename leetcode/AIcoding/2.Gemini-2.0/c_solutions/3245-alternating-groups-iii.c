#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* alternatingGroupsIII(int n, int* returnSize) {
    int* result = (int*)malloc(n * sizeof(int));
    *returnSize = n;
    for (int i = 0; i < n; i++) {
        if (i % 2 == 0) {
            result[i] = (i / 2) + 1;
        } else {
            result[i] = n - (i / 2);
        }
    }
    return result;
}