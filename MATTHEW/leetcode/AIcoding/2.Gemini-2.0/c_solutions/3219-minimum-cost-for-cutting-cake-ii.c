#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return *(int *)a - *(int *)b;
}

int minCost(int n, int *horizontalCuts, int horizontalCutsSize, int *verticalCuts, int verticalCutsSize) {
    qsort(horizontalCuts, horizontalCutsSize, sizeof(int), cmp);
    qsort(verticalCuts, verticalCutsSize, sizeof(int), cmp);

    long long hMax = 0, vMax = 0;
    int prev = 0;
    for (int i = 0; i < horizontalCutsSize; i++) {
        hMax = (hMax > (horizontalCuts[i] - prev)) ? hMax : (horizontalCuts[i] - prev);
        prev = horizontalCuts[i];
    }
    hMax = (hMax > (n - prev)) ? hMax : (n - prev);

    prev = 0;
    for (int i = 0; i < verticalCutsSize; i++) {
        vMax = (vMax > (verticalCuts[i] - prev)) ? vMax : (verticalCuts[i] - prev);
        prev = verticalCuts[i];
    }
    vMax = (vMax > (n - prev)) ? vMax : (n - prev);

    long long ans = (hMax * vMax) % 1000000007;
    return (int)ans;
}