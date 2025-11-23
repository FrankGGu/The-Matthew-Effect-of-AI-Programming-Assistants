#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)b - *(int*)a);
}

int buyCandies(int* prices, int pricesSize, int money) {
    qsort(prices, pricesSize, sizeof(int), compare);
    int total = 0;
    for (int i = 0; i < pricesSize; i++) {
        if (total + prices[i] > money) {
            break;
        }
        total += prices[i];
    }
    return money - total;
}