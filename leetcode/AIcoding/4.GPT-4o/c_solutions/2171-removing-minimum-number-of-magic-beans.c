#include <stdio.h>
#include <stdlib.h>

int minimumRemoval(int* beans, int beansSize) {
    long long total = 0, minRemoval = LLONG_MAX;

    for (int i = 0; i < beansSize; i++) {
        total += beans[i];
    }

    qsort(beans, beansSize, sizeof(int), cmp);

    for (int i = 0; i < beansSize; i++) {
        long long removal = total - (long long)beans[i] * (beansSize - i);
        if (removal < minRemoval) {
            minRemoval = removal;
        }
    }

    return (int)minRemoval;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}