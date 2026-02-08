#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int price;
    int quantity;
} Item;

typedef struct {
    int* prices;
    int* quantities;
    int size;
} Offer;

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int dfs(int* price, int* special, int* needs, int n, int m, int** offers, int offerSize) {
    int total = 0;
    for (int i = 0; i < n; i++) {
        total += price[i] * needs[i];
    }

    for (int i = 0; i < offerSize; i++) {
        int valid = 1;
        for (int j = 0; j < n; j++) {
            if (needs[j] < offers[i][j]) {
                valid = 0;
                break;
            }
        }
        if (valid) {
            int* newNeeds = (int*)malloc(n * sizeof(int));
            for (int j = 0; j < n; j++) {
                newNeeds[j] = needs[j] - offers[i][j];
            }
            int cost = dfs(price, special, newNeeds, n, m, offers, offerSize);
            free(newNeeds);
            total = (cost + offers[i][n] < total) ? cost + offers[i][n] : total;
        }
    }

    return total;
}

int shoppingOffers(int* price, int priceSize, int** special, int specialSize, int* needs, int needsSize) {
    int n = priceSize;
    int** offers = (int**)malloc(specialSize * sizeof(int*));
    for (int i = 0; i < specialSize; i++) {
        offers[i] = (int*)malloc((n + 1) * sizeof(int));
        for (int j = 0; j < n; j++) {
            offers[i][j] = special[i][j];
        }
        offers[i][n] = special[i][n];
    }

    int result = dfs(price, *special, needs, n, specialSize, offers, specialSize);

    for (int i = 0; i < specialSize; i++) {
        free(offers[i]);
    }
    free(offers);

    return result;
}