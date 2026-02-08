#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int* maxBuildingHeight(int* constraints, int constraintsSize, int* returnSize) {
    int n = constraintsSize / 2;
    int** buildings = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        buildings[i] = (int*)malloc(2 * sizeof(int));
        buildings[i][0] = constraints[2 * i];
        buildings[i][1] = constraints[2 * i + 1];
    }

    qsort(buildings, n, sizeof(int*), compare);

    int* result = (int*)malloc(n * sizeof(int));
    int maxH = 0;

    for (int i = 0; i < n; i++) {
        int pos = buildings[i][0];
        int h = buildings[i][1];
        if (h > maxH) {
            maxH = h;
        }
        result[i] = maxH;
    }

    *returnSize = n;
    return result;
}