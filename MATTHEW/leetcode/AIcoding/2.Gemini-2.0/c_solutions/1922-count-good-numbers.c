#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int MOD = 1000000007;

long long power(long long base, long long exp) {
    long long res = 1;
    base %= MOD;
    while (exp > 0) {
        if (exp % 2 == 1) res = (res * base) % MOD;
        base = (base * base) % MOD;
        exp /= 2;
    }
    return res;
}

int countGoodNumbers(long long n) {
    long long odd = n / 2;
    long long even = n - odd;
    return (power(5, even) * power(4, odd)) % MOD;
}