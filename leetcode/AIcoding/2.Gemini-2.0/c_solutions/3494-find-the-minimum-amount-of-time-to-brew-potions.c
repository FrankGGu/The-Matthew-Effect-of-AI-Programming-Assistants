#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(long long*)a - *(long long*)b);
}

long long minCostToBrew(int mix, int brew, int n, int *potions) {
    long long *potionLong = (long long*)malloc(n * sizeof(long long));
    for (int i = 0; i < n; i++) {
        potionLong[i] = (long long)potions[i];
    }

    qsort(potionLong, n, sizeof(long long), compare);

    long long totalCost = 0;
    for (int i = 0; i < n; i++) {
        if (mix > brew) {
            totalCost += brew * potionLong[i];
            mix -= brew;
        } else {
            totalCost += mix * potionLong[i];
            mix = 0;
        }
    }

    free(potionLong);
    return totalCost;
}