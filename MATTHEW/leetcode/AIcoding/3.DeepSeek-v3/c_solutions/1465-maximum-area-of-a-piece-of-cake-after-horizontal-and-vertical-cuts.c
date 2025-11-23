#include <stdlib.h>

int compare(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

int maxArea(int h, int w, int* horizontalCuts, int horizontalCutsSize, int* verticalCuts, int verticalCutsSize) {
    qsort(horizontalCuts, horizontalCutsSize, sizeof(int), compare);
    qsort(verticalCuts, verticalCutsSize, sizeof(int), compare);

    int maxH = horizontalCuts[0];
    for (int i = 1; i < horizontalCutsSize; i++) {
        int diff = horizontalCuts[i] - horizontalCuts[i - 1];
        if (diff > maxH) maxH = diff;
    }
    if (h - horizontalCuts[horizontalCutsSize - 1] > maxH) {
        maxH = h - horizontalCuts[horizontalCutsSize - 1];
    }

    int maxW = verticalCuts[0];
    for (int i = 1; i < verticalCutsSize; i++) {
        int diff = verticalCuts[i] - verticalCuts[i - 1];
        if (diff > maxW) maxW = diff;
    }
    if (w - verticalCuts[verticalCutsSize - 1] > maxW) {
        maxW = w - verticalCuts[verticalCutsSize - 1];
    }

    return (long)maxH * maxW % 1000000007;
}