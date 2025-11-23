#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int accountBalanceAfterPurchase(int purchaseAmount) {
    int roundedAmount = (purchaseAmount % 10 >= 5) ? (purchaseAmount / 10 + 1) * 10 : (purchaseAmount / 10) * 10;
    return 100 - roundedAmount;
}