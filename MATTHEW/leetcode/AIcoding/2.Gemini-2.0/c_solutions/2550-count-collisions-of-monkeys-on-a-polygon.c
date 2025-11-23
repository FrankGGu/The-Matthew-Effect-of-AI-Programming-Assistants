#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countCollisions(int n) {
    long long ans = 1;
    long long mod = 1e9 + 7;
    long long base = 2;

    while (n > 0) {
        if (n % 2 == 1) {
            ans = (ans * base) % mod;
        }
        base = (base * base) % mod;
        n /= 2;
    }

    return (ans - 2 + mod) % mod;
}