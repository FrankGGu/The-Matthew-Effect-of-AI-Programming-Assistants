#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

long long removeBeans(int* beans, int beansSize) {
    if (beansSize == 0) {
        return 0;
    }

    qsort(beans, beansSize, sizeof(int), compare);

    long long totalSum = 0;
    for (int i = 0; i < beansSize; i++) {
        totalSum += beans[i];
    }

    long long maxRemainingBeans = 0;

    for (int i = 0; i < beansSize; i++) {
        long long currentRemaining = (long long)(beansSize - i) * beans[i];
        if (currentRemaining > maxRemainingBeans) {
            maxRemainingBeans = currentRemaining;
        }
    }

    return totalSum - maxRemainingBeans;
}