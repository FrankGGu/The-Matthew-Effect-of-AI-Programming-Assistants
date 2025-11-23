#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int buyTwoChocolates(int* prices, int pricesSize, int money) {
    int min1 = 200, min2 = 200;
    for (int i = 0; i < pricesSize; i++) {
        if (prices[i] < min1) {
            min2 = min1;
            min1 = prices[i];
        } else if (prices[i] < min2) {
            min2 = prices[i];
        }
    }
    if (min1 + min2 <= money) {
        return money - (min1 + min2);
    } else {
        return money;
    }
}