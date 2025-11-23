#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007

long long factorial(int n, long long* fact) {
    if (fact[n] != -1) {
        return fact[n];
    }
    if (n == 0) {
        fact[0] = 1;
        return 1;
    }
    fact[n] = (n * factorial(n - 1, fact)) % MOD;
    return fact[n];
}

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

long long modInverse(long long n) {
    return power(n, MOD - 2);
}

int countWays(int* prevRoom, int prevRoomSize) {
    int n = prevRoomSize + 1;
    long long* fact = (long long*)malloc((n + 1) * sizeof(long long));
    for (int i = 0; i <= n; i++) {
        fact[i] = -1;
    }
    factorial(n, fact);

    int* sizes = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        sizes[i] = 1;
    }

    for (int i = 1; i < n; i++) {
        sizes[prevRoom[i - 1]] += sizes[i];
    }

    long long result = fact[n - 1];
    for (int i = 0; i < n; i++) {
        result = (result * modInverse(fact[sizes[i] - 1])) % MOD;
    }

    free(fact);
    free(sizes);

    return (int)result;
}