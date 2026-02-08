#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return *(int*)a - *(int*)b;
}

long long maxSpending(int** costs, int costsSize, int* costsColSize) {
    int n = costsSize;
    int m = costsColSize[0];
    long long totalSpending = 0;
    int purchased[n];
    for (int i = 0; i < n; i++) {
        purchased[i] = m - 1;
    }

    for (int day = 0; day < n * m; day++) {
        int maxCost = -1;
        int maxShop = -1;

        for (int i = 0; i < n; i++) {
            if (purchased[i] >= 0 && costs[i][purchased[i]] > maxCost) {
                maxCost = costs[i][purchased[i]];
                maxShop = i;
            }
        }

        totalSpending += (long long)maxCost;
        purchased[maxShop]--;
    }

    return totalSpending;
}