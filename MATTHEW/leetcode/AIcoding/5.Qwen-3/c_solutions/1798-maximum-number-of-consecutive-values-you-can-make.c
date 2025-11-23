#include <stdio.h>
#include <stdlib.h>

int getMaximumConsecutive(int* coins, int coinsSize) {
    qsort(coins, coinsSize, sizeof(int), (int (*)(const void*, const void*))strcmp);
    int res = 0;
    for (int i = 0; i < coinsSize; i++) {
        if (coins[i] > res + 1) break;
        res += coins[i];
    }
    return res + 1;
}