#include <stdlib.h>

int* sumZero(int n, int* returnSize) {
    int* result = (int*)malloc(n * sizeof(int));
    *returnSize = n;

    int current = 1;
    int index = 0;

    for (int i = 0; i < n / 2; ++i) {
        result[index++] = current;
        result[index++] = -current;
        current++;
    }

    if (n % 2 == 1) {
        result[index] = 0;
    }

    return result;
}