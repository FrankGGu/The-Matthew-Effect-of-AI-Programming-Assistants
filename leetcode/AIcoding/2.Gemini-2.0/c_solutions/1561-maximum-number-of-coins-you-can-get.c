#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maxCoins(int* piles, int pilesSize){
    qsort(piles, pilesSize, sizeof(int), compare);

    int coins = 0;
    int left = 0;
    int right = pilesSize - 2;

    while (left < right) {
        coins += piles[right];
        left++;
        right -= 2;
    }

    return coins;
}