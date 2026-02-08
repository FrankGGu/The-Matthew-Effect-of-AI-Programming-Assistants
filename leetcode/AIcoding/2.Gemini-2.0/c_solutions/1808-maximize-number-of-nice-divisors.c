#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007

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

int maxNiceDivisors(int primeFactors) {
    if (primeFactors <= 3) {
        return primeFactors;
    }

    if (primeFactors % 3 == 0) {
        return power(3, primeFactors / 3);
    } else if (primeFactors % 3 == 1) {
        return (power(3, (primeFactors - 4) / 3) * 4) % MOD;
    } else {
        return (power(3, primeFactors / 3) * 2) % MOD;
    }
}