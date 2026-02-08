#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maximumTotalImportance(int* n, int nSize, int** roads, int roadsSize, int* roadsColSize) {
    int* import = (int*)malloc((*n) * sizeof(int));
    for (int i = 0; i < *n; i++) {
        import[i] = 0;
    }

    for (int i = 0; i < roadsSize; i++) {
        for (int j = 0; j < roadsColSize[i]; j++) {
            import[roads[i][j]]++;
        }
    }

    qsort(import, *n, sizeof(int), compare);

    int total = 0;
    for (int i = 0; i < *n; i++) {
        total += import[i] * (i + 1);
    }

    free(import);
    return total;
}