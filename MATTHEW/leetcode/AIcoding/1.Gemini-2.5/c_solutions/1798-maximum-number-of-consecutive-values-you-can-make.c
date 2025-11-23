#include <stdlib.h>

int compareIntegers(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int getMaximumConsecutive(int* coins, int coinsSize) {
    qsort(coins, coinsSize, sizeof(int), compareIntegers);

    long long reachable = 0;

    for (int i = 0; i < coinsSize; i++) {
        if (coins[i] > reachable + 1) {
            break;
        }
        reachable += coins[i];
    }

    return (int)(reachable + 1);
}