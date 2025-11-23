#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int cmpfunc(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int maxSquareArea(int* leftFences, int leftFencesSize, int* rightFences, int rightFencesSize, int* frontFences, int frontFencesSize, int* backFences, int backFencesSize) {
    qsort(leftFences, leftFencesSize, sizeof(int), cmpfunc);
    qsort(rightFences, rightFencesSize, sizeof(int), cmpfunc);
    qsort(frontFences, frontFencesSize, sizeof(int), cmpfunc);
    qsort(backFences, backFencesSize, sizeof(int), cmpfunc);

    int* horizontal = (int*)malloc((frontFencesSize + backFencesSize + 2) * sizeof(int));
    int* vertical = (int*)malloc((leftFencesSize + rightFencesSize + 2) * sizeof(int));

    horizontal[0] = 0;
    for (int i = 0; i < frontFencesSize; i++) {
        horizontal[i + 1] = frontFences[i];
    }
    for (int i = 0; i < backFencesSize; i++) {
        horizontal[frontFencesSize + i + 1] = backFences[i];
    }
    horizontal[frontFencesSize + backFencesSize + 1] = INT_MAX;

    vertical[0] = 0;
    for (int i = 0; i < leftFencesSize; i++) {
        vertical[i + 1] = leftFences[i];
    }
    for (int i = 0; i < rightFencesSize; i++) {
        vertical[leftFencesSize + i + 1] = rightFences[i];
    }
    vertical[leftFencesSize + rightFencesSize + 1] = INT_MAX;

    qsort(horizontal, frontFencesSize + backFencesSize + 2, sizeof(int), cmpfunc);
    qsort(vertical, leftFencesSize + rightFencesSize + 2, sizeof(int), cmpfunc);

    int h = 0, v = 0;
    int maxSide = 0;

    while (h < frontFencesSize + backFencesSize + 1 && v < leftFencesSize + rightFencesSize + 1) {
        int hDiff = horizontal[h + 1] - horizontal[h];
        int vDiff = vertical[v + 1] - vertical[v];

        if (hDiff == vDiff) {
            maxSide = hDiff;
            h++;
            v++;
        } else if (hDiff < vDiff) {
            h++;
        } else {
            v++;
        }
    }

    free(horizontal);
    free(vertical);
    return maxSide * maxSide;
}