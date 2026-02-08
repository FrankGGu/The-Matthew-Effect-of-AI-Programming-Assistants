#include <limits.h>

int buyChoco(int* prices, int pricesSize, int money) {
    int min1 = INT_MAX;
    int min2 = INT_MAX;

    for (int i = 0; i < pricesSize; i++) {
        if (prices[i] < min1) {
            min2 = min1;
            min1 = prices[i];
        } else if (prices[i] < min2) {
            min2 = prices[i];
        }
    }

    int remainingMoney = money - (min1 + min2);

    if (remainingMoney >= 0) {
        return remainingMoney;
    } else {
        return money;
    }
}