#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int arrangeCoins(int n) {
    long long left = 0, right = n;
    long long k;
    while (left <= right) {
        k = left + (right - left) / 2;
        long long coinsNeeded = k * (k + 1) / 2;
        if (coinsNeeded == n) {
            return (int)k;
        } else if (coinsNeeded < n) {
            left = k + 1;
        } else {
            right = k - 1;
        }
    }
    return (int)right;
}