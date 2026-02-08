#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* constructArray(int n, int k, int* returnSize) {
    int* result = (int*)malloc(n * sizeof(int));
    *returnSize = n;

    int left = 1;
    int right = k + 1;
    int index = 0;

    while (left <= right) {
        if (k % 2 != 0) {
            result[index++] = left++;
        } else {
            result[index++] = right--;
        }
        k--;
    }

    for (int i = k + 2; i <= n; i++) {
        result[index++] = i;
    }

    return result;
}