#include <stdlib.h>

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int getMaximumConsecutive(int* coins, int coinsSize) {
    qsort(coins, coinsSize, sizeof(int), cmp);
    int res = 1;
    for (int i = 0; i < coinsSize; i++) {
        if (coins[i] > res) {
            break;
        }
        res += coins[i];
    }
    return res;
}