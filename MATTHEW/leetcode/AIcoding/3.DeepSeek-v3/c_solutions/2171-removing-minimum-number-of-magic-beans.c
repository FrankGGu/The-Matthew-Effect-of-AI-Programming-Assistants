#include <stdlib.h>
#include <string.h>

int cmp(const void* a, const void* b) {
    return *(long long*)a - *(long long*)b;
}

long long minimumRemoval(int* beans, int beansSize) {
    long long* sorted = (long long*)malloc(beansSize * sizeof(long long));
    for (int i = 0; i < beansSize; i++) {
        sorted[i] = beans[i];
    }
    qsort(sorted, beansSize, sizeof(long long), cmp);

    long long total = 0;
    for (int i = 0; i < beansSize; i++) {
        total += sorted[i];
    }

    long long min_removal = total;
    for (int i = 0; i < beansSize; i++) {
        long long removal = total - sorted[i] * (beansSize - i);
        if (removal < min_removal) {
            min_removal = removal;
        }
    }

    free(sorted);
    return min_removal;
}