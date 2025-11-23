#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minPatches(int* coins, int coinsSize, int amount) {
    qsort(coins, coinsSize, sizeof(int), compare);
    long long reach = 0;
    int patches = 0;
    int i = 0;
    while (reach < amount) {
        if (i < coinsSize && coins[i] <= reach + 1) {
            reach += coins[i];
            i++;
        } else {
            patches++;
            reach += reach + 1;
        }
    }
    return patches;
}