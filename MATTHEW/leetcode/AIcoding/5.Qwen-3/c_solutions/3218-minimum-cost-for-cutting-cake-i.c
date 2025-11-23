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
        maxH = (maxH > horizontalCuts[i] - prev) ? maxH : horizontalCuts[i] - prev;
        prev = horizontalCuts[i];
    }
    maxH = (maxH > (1000000000 - prev)) ? maxH : (1000000000 - prev);

    int maxV = 0;
    prev = 0;
    for (int i = 0; i < verticalCutsSize; i++) {
        maxV = (maxV > verticalCuts[i] - prev) ? maxV : verticalCuts[i] - prev;
        prev = verticalCuts[i];
    }
    maxV = (maxV > (1000000000 - prev)) ? maxV : (1000000000 - prev);

    return maxH * maxV;
}