#include <stdio.h>
#include <stdlib.h>

int* lexicalOrder(int n, int* returnSize) {
    int* result = (int*)malloc(n * sizeof(int));
    int index = 0;

    for (int i = 1; i <= n; i++) {
        result[index++] = i;
    }

    for (int i = 1; i <= n; i++) {
        for (int j = i * 10; j <= n; j *= 10) {
            result[index++] = j;
        }
    }

    *returnSize = n;
    return result;
}