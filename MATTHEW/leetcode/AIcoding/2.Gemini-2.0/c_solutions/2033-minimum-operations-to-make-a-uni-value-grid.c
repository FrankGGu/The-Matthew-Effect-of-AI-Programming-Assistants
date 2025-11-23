#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minOperations(int** grid, int gridSize, int* gridColSize, int x) {
    int n = gridSize;
    int m = gridColSize[0];
    int size = n * m;
    int* arr = (int*)malloc(size * sizeof(int));
    int k = 0;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            arr[k++] = grid[i][j];
        }
    }

    qsort(arr, size, sizeof(int), compare);

    int median = arr[size / 2];
    int operations = 0;
    for (int i = 0; i < size; i++) {
        int diff = abs(arr[i] - median);
        if (diff % x != 0) {
            free(arr);
            return -1;
        }
        operations += diff / x;
    }

    free(arr);
    return operations;
}