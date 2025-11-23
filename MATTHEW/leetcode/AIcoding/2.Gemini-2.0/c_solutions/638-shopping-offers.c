#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int shoppingOffers(int* price, int priceSize, int** special, int specialSize, int* specialColSize, int* needs, int needsSize) {
    int min_cost = 0;
    for (int i = 0; i < needsSize; i++) {
        min_cost += price[i] * needs[i];
    }

    for (int i = 0; i < specialSize; i++) {
        int* offer = special[i];
        int can_use = 1;
        for (int j = 0; j < needsSize; j++) {
            if (needs[j] < offer[j]) {
                can_use = 0;
                break;
            }
        }

        if (can_use) {
            int* new_needs = (int*)malloc(sizeof(int) * needsSize);
            for (int j = 0; j < needsSize; j++) {
                new_needs[j] = needs[j] - offer[j];
            }

            int cost = offer[needsSize] + shoppingOffers(price, priceSize, special, specialSize, specialColSize, new_needs, needsSize);
            if (cost < min_cost) {
                min_cost = cost;
            }
            free(new_needs);
        }
    }

    return min_cost;
}