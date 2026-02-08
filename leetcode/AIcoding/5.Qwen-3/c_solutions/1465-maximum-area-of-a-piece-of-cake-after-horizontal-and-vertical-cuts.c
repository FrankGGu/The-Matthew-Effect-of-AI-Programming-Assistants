#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maxArea(int h, int w, int* horizontalCuts, int horizontalCutsSize, int* verticalCuts, int verticalCutsSize) {
    qsort(horizontalCuts, horizontalCutsSize, sizeof(int), compare);
    qsort(verticalCuts, verticalCutsSize, sizeof(int), compare);

    int maxH = 0;
    int prev = 0;
    for (int i = 0; i < horizontalCutsSize; i++) {
        maxH = (maxH < horizontalCuts[i] - prev) ? (horizontalCuts[i] - prev) : maxH;
        prev = horizontalCuts[i];
    }
    maxH = (maxH < h - prev) ? (h - prev) : maxH;

    int maxW = 0;
    prev = 0;
    for (int i = 0; i < verticalCutsSize; i++) {
        maxW = (maxW < verticalCuts[i] - prev) ? (verticalCuts[i] - prev) : maxW;
        prev = verticalCuts[i];
    }
    maxW = (maxW < w - prev) ? (w - prev) : maxW;

    return maxH * maxW;
}