#include <stdio.h>
#include <stdlib.h>

int* beautifulArray(int n, int* returnSize) {
    int* result = (int*)malloc(n * sizeof(int));
    *returnSize = n;

    if (n == 0) return NULL;

    result[0] = 1;
    for (int i = 2; i <= n; i++) {
        int* temp = (int*)malloc(n * sizeof(int));
        int index = 0;
        for (int j = 0; j < i - 1; j++) {
            temp[index++] = result[j] * 2 - 1;
        }
        for (int j = 0; j < i - 1; j++) {
            temp[index++] = result[j] * 2;
        }
        free(result);
        result = temp;
    }

    return result;
}