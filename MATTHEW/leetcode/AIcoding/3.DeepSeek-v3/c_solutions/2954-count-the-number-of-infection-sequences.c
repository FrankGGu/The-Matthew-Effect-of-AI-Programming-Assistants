#include <stdlib.h>
#include <string.h>

#define MOD 1000000007

long long power(long long x, long long y) {
    long long res = 1;
    x %= MOD;
    while (y > 0) {
        if (y & 1) {
            res = (res * x) % MOD;
        }
        y >>= 1;
        x = (x * x) % MOD;
    }
    return res;
}

long long modInverse(long long n) {
    return power(n, MOD - 2);
}

long long factorial(int n) {
    long long res = 1;
    for (int i = 2; i <= n; i++) {
        res = (res * i) % MOD;
    }
    return res;
}

long long nCr(int n, int r) {
    if (r < 0 || r > n) return 0;
    if (r == 0 || r == n) return 1;
    long long num = factorial(n);
    long long den = (factorial(r) * factorial(n - r)) % MOD;
    return (num * modInverse(den)) % MOD;
}

int numberOfSequence(int n, int* sick, int sickSize) {
    long long res = 1;
    int total = n - sickSize;
    res = factorial(total);

    int* gaps = (int*)malloc((sickSize + 1) * sizeof(int));
    gaps[0] = sick[0];
    for (int i = 1; i < sickSize; i++) {
        gaps[i] = sick[i] - sick[i-1] - 1;
    }
    gaps[sickSize] = n - sick[sickSize-1] - 1;

    for (int i = 0; i <= sickSize; i++) {
        if (gaps[i] > 0) {
            res = (res * modInverse(factorial(gaps[i]))) % MOD;
        }
    }

    for (int i = 1; i < sickSize; i++) {
        if (gaps[i] > 0) {
            res = (res * power(2, gaps[i] - 1)) % MOD;
        }
    }

    free(gaps);
    return res;
}