#include <stdio.h>
#include <stdlib.h>

int* kthSmallestPrimeFraction(int** a, int size, int k, int* returnSize) {
    int* result = (int*)malloc(2 * sizeof(int));
    *returnSize = 2;

    int* temp = (int*)malloc(size * size * sizeof(int));
    int index = 0;

    for (int i = 0; i < size; i++) {
        for (int j = i + 1; j < size; j++) {
            temp[index++] = a[i][0] * size + a[j][0];
        }
    }

    qsort(temp, index, sizeof(int), (int (*)(const void*, const void*))strcmp);

    int val = temp[k - 1];
    int x = val / size;
    int y = val % size;

    result[0] = x;
    result[1] = y;

    free(temp);
    return result;
}