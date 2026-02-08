#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countHousePlacements(int n) {
    long long mod = 1000000007;
    long long a = 1, b = 2;
    for (int i = 2; i <= n; i++) {
        long long temp = (a + b) % mod;
        a = b;
        b = temp;
    }
    return (int)((b * b) % mod);
}