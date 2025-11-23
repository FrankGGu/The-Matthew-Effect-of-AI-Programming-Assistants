#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* grayCode(int n, int* returnSize){
    *returnSize = 1 << n;
    int *result = (int*)malloc(sizeof(int) * (*returnSize));
    result[0] = 0;
    for (int i = 1; i <= n; i++) {
        int mask = 1 << (i - 1);
        for (int j = (1 << (i - 1)) - 1; j >= 0; j--) {
            result[(1 << (i - 1)) + j] = result[j] | mask;
        }
    }
    return result;
}