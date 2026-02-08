#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)b - *(int*)a);
}

long long maxHappinessSum(int* happiness, int happinessSize, int k) {
    qsort(happiness, happinessSize, sizeof(int), compare);

    long long totalHappiness = 0;
    for (int i = 0; i < k; i++) {
        long long currentEffectiveHappiness = (long long)happiness[i] - i;
        if (currentEffectiveHappiness > 0) {
            totalHappiness += currentEffectiveHappiness;
        } else {
            break;
        }
    }

    return totalHappiness;
}