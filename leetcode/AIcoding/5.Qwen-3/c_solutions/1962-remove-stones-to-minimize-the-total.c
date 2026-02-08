#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)b - *(int*)a);
}

int minStoneSum(int* piles, int pilesSize, int k) {
    for (int i = 0; i < k; i++) {
        qsort(piles, pilesSize, sizeof(int), compare);
        piles[0] = piles[0] - piles[0] / 2;
    }
    int total = 0;
    for (int i = 0; i < pilesSize; i++) {
        total += piles[i];
    }
    return total;
}