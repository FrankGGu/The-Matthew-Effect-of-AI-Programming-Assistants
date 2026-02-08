#include <stdio.h>
#include <stdlib.h>

int* distinctIntegers(int n, int* returnSize) {
    int* result = (int*)malloc(3 * sizeof(int));
    if (n < 3) {
        *returnSize = 0;
        return NULL;
    }
    result[0] = n - 2;
    result[1] = n - 1;
    result[2] = n;
    *returnSize = 3;
    return result;
}