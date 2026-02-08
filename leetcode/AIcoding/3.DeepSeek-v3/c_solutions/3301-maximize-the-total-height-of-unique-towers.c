#include <stdlib.h>

int cmp(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

long long maximumTotalSum(int* maximumHeight, int maximumHeightSize) {
    qsort(maximumHeight, maximumHeightSize, sizeof(int), cmp);

    long long total = maximumHeight[maximumHeightSize - 1];
    int current = maximumHeight[maximumHeightSize - 1];

    for (int i = maximumHeightSize - 2; i >= 0; i--) {
        if (current == 0) {
            return -1;
        }

        if (maximumHeight[i] < current) {
            current = maximumHeight[i];
        } else {
            current = current - 1;
        }

        if (current <= 0) {
            return -1;
        }

        total += current;
    }

    return total;
}