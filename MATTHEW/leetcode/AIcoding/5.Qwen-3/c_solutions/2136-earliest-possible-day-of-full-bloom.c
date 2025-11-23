#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    int x = *(int*)a;
    int y = *(int*)b;
    return x - y;
}

int earliestDay(int* bloomDays, int bloomDaysSize, int* growDays, int growDaysSize) {
    int n = bloomDaysSize;
    int** pairs = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        pairs[i] = (int*)malloc(2 * sizeof(int));
        pairs[i][0] = bloomDays[i];
        pairs[i][1] = growDays[i];
    }

    qsort(pairs, n, sizeof(int*), compare);

    int maxTime = 0;
    int currentTime = 0;

    for (int i = 0; i < n; i++) {
        currentTime += pairs[i][0];
        maxTime = (currentTime + pairs[i][1] > maxTime) ? currentTime + pairs[i][1] : maxTime;
    }

    for (int i = 0; i < n; i++) {
        free(pairs[i]);
    }
    free(pairs);

    return maxTime;
}