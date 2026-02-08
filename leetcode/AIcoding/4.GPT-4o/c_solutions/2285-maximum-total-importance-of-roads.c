#include <stdlib.h>

long long maximumImportance(int n, int** roads, int roadsSize, int* roadsColSize) {
    long long* importance = (long long*)calloc(n, sizeof(long long));
    for (int i = 0; i < roadsSize; i++) {
        importance[roads[i][0]]++;
        importance[roads[i][1]]++;
    }

    long long* sortedImportance = (long long*)malloc(n * sizeof(long long));
    for (int i = 0; i < n; i++) {
        sortedImportance[i] = importance[i];
    }

    qsort(sortedImportance, n, sizeof(long long), (int(*)(const void*, const void*)) strcmp);

    long long totalImportance = 0;
    for (int i = 0; i < n; i++) {
        totalImportance += sortedImportance[i] * (i + 1);
    }

    free(importance);
    free(sortedImportance);
    return totalImportance;
}