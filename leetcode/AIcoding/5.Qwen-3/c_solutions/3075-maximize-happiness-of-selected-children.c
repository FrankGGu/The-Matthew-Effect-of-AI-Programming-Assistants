#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)b - *(int*)a);
}

long long maxHappiness(long long* happiness, int happinessSize, int k) {
    qsort(happiness, happinessSize, sizeof(long long), compare);
    long long total = 0;
    for (int i = 0; i < k; i++) {
        if (happiness[i] > 0) {
            total += happiness[i];
        }
    }
    return total;
}