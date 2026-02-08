#include <stdio.h>
#include <stdlib.h>

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int kthSmallest(int** matrix, int matrixSize, int* matrixColSize, int k) {
    int n = matrixSize;
    int* flat = (int*)malloc(n * n * sizeof(int));
    int index = 0;

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            flat[index++] = matrix[i][j];
        }
    }

    qsort(flat, n * n, sizeof(int), compare);
    int result = flat[k - 1];
    free(flat);
    return result;
}