#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minCost(int* horizontalCuts, int horizontalCutsSize, int* verticalCuts, int verticalCutsSize) {
    qsort(horizontalCuts, horizontalCutsSize, sizeof(int), compare);
    qsort(verticalCuts, verticalCutsSize, sizeof(int), compare);

    int maxH = 0;
    int prev = 0;
    for (int i = 0; i < horizontalCutsSize; i++) {
        maxH = (maxH < horizontalCuts[i] - prev) ? (horizontalCuts[i] - prev) : maxH;
        prev = horizontalCuts[i];
    }
    maxH = (maxH < (1000000000 - prev)) ? (1000000000 - prev) : maxH;

    int maxV = 0;
    prev = 0;
    for (int i = 0; i < verticalCutsSize; i++) {
        maxV = (maxV < verticalCuts[i] - prev) ? (verticalCuts[i] - prev) : maxV;
        prev = verticalCuts[i];
    }
    maxV = (maxV < (1000000000 - prev)) ? (1000000000 - prev) : maxV;

    return (maxH * maxV) % 1000000007;
}