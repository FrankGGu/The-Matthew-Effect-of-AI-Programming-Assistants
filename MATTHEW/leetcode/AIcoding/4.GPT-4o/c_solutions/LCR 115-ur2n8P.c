#include <stdio.h>
#include <stdlib.h>

int cmp(const void *a, const void *b) {
    return (*(int *)a - *(int *)b;
}

int* construct(int* original, int originalSize, int* order, int orderSize, int* returnSize) {
    if (originalSize != orderSize) {
        *returnSize = 0;
        return NULL;
    }

    int *result = (int *)malloc(originalSize * sizeof(int));
    for (int i = 0; i < originalSize; i++) {
        result[order[i] - 1] = original[i];
    }

    *returnSize = originalSize;
    return result;
}