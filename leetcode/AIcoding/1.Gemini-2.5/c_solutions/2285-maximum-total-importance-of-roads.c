#include <stdlib.h>

int compareIntegers(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

long long maximumImportance(int n, int** roads, int roadsSize, int* roadsColSize) {
    int* degrees = (int*)calloc(n, sizeof(int));

    for (int i = 0; i < roadsSize; i++) {
        degrees[roads[i][0]]++;
        degrees[roads[i][1]]++;
    }

    qsort(degrees, n, sizeof(int), compareIntegers);

    long long totalImportance = 0;
    for (int i = 0; i < n; i++) {
        totalImportance += (long long)degrees[i] * (i + 1);
    }

    free(degrees);
    return totalImportance;
}