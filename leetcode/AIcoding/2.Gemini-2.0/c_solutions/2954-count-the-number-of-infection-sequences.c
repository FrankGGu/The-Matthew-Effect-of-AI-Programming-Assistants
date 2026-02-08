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

long long inverse(long long n) {
    return power(n, MOD - 2);
}

long long combinations(int n, int k) {
    if (k < 0 || k > n) return 0;
    if (k == 0 || k == n) return 1;
    if (k > n / 2) k = n - k;

    long long res = 1;
    for (int i = 1; i <= k; ++i) {
        res = (res * (n - i + 1)) % MOD;
        res = (res * inverse(i)) % MOD;
    }
    return res;
}

int countInfectionSequences(int n, int k) {
    long long comb = combinations(n, k);
    long long fact = 1;
    for (int i = 1; i <= k; ++i) {
        fact = (fact * i) % MOD;
    }
    long long pw = power(2, k - 1);
    return (comb * fact % MOD * pw % MOD);
}