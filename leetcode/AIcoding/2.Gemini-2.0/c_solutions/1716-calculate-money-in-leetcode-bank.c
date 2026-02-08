#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int totalMoney(int n) {
    int weeks = n / 7;
    int remainingDays = n % 7;
    int total = 0;

    total += weeks * (28 + 7 * (weeks - 1)) / 2;
    total += (weeks + 1 + weeks + remainingDays) * remainingDays / 2;

    return total;
}