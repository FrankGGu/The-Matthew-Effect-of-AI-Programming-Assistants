#include <stdio.h>
#include <stdlib.h>

int coinBonus(int* coins, int coinsSize) {
    int max = 0;
    for (int i = 0; i < coinsSize; i++) {
        if (coins[i] > max) {
            max = coins[i];
        }
    }
    int count = 0;
    for (int i = 0; i < coinsSize; i++) {
        if (coins[i] == max) {
            count++;
        }
    }
    return count;
}