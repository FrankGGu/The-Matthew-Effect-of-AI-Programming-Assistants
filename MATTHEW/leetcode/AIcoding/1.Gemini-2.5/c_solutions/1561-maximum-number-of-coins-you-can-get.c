#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maxCoins(int* piles, int pilesSize) {
    qsort(piles, pilesSize, sizeof(int), compare);

    int max_coins = 0;
    int n = pilesSize / 3;

    int left = 0;
    int right = pilesSize - 1;

    for (int i = 0; i < n; i++) {
        right--; 
        max_coins += piles[right];
        right--; 
        left++; 
    }

    return max_coins;
}