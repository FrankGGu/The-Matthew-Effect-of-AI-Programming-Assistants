#include <stdio.h>
#include <stdlib.h>

double accountBalanceAfterPurchase(int money) {
    int remainder = money % 10;
    if (remainder < 5) {
        return money - remainder;
    } else {
        return money + (10 - remainder);
    }
}