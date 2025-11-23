#include <stdlib.h>

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int maxIncreasingGroups(int* usageLimits, int usageLimitsSize) {
    qsort(usageLimits, usageLimitsSize, sizeof(int), cmp);

    long long total = 0;
    int k = 0;

    for (int i = 0; i < usageLimitsSize; i++) {
        total += usageLimits[i];
        if (total >= ((long long)(k + 1) * (k + 2)) / 2) {
            k++;
        }
    }

    return k;
}