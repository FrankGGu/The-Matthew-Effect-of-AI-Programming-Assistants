#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* countBits(int n, int* returnSize){
    int *result = (int*)malloc((n + 1) * sizeof(int));
    *returnSize = n + 1;
    result[0] = 0;
    for (int i = 1; i <= n; i++) {
        result[i] = result[i >> 1] + (i & 1);
    }
    return result;
}