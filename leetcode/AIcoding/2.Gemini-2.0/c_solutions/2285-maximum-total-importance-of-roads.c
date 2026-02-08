#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int *)b) - (*(int *)a);
}

long long maximumImportance(int n, int** roads, int roadsSize, int* roadsColSize) {
    int degrees[n];
    for (int i = 0; i < n; i++) {
        degrees[i] = 0;
    }

    for (int i = 0; i < roadsSize; i++) {
        degrees[roads[i][0]]++;
        degrees[roads[i][1]]++;
    }

    qsort(degrees, n, sizeof(int), compare);

    long long totalImportance = 0;
    for (int i = 0; i < n; i++) {
        totalImportance += (long long)degrees[i] * (n - i);
    }

    return totalImportance;
}