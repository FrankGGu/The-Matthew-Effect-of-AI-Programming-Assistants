#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* constructArray(int n, int k, int* returnSize) {
    int* result = (int*)malloc(n * sizeof(int));
    *returnSize = n;
    int start = 1;
    int end = k + 1;
    int index = 0;
    int reverse = 0;
    while (start <= end) {
        if (reverse == 0) {
            result[index++] = start++;
        } else {
            result[index++] = end--;
        }
        reverse = 1 - reverse;
    }
    for (int i = k + 2; i <= n; i++) {
        result[index++] = i;
    }
    return result;
}