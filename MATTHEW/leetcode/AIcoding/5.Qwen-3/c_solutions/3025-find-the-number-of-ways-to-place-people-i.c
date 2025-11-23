#include <stdio.h>
#include <stdlib.h>

int numberOfWays(int** positions, int positionsSize, int* positionsColSize, int x) {
    int n = positionsSize;
    int* pos = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        pos[i] = positions[i][0];
    }

    qsort(pos, n, sizeof(int), (int (*)(const void*, const void*))strcmp);

    int count = 0;
    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            if (pos[j] - pos[i] > x) break;
            count++;
        }
    }

    free(pos);
    return count;
}