#include <stdlib.h>
#include <string.h>

#define MOD 1000000007
#define MAXN 10020
#define MAXK 10020

long long fact[MAXN + MAXK], invfact[MAXN + MAXK];

long long powmod(long long a, long long b) {
    long long res = 1;
    a %= MOD;
    for (; b; b >>= 1) {
        if (b & 1) res = res * a % MOD;
        a = a * a % MOD;
    }
    return res;
}

void init() {
    fact[0] = 1;
    for (int i = 1; i < MAXN + MAXK; i++) {
        fact[i] = fact[i-1] * i % MOD;
    }
    invfact[MAXN + MAXK - 1] = powmod(fact[MAXN + MAXK - 1], MOD - 2);
    for (int i = MAXN + MAXK - 2; i >= 0; i--) {
        invfact[i] = invfact[i+1] * (i+1) % MOD;
    }
}

long long nCr(int n, int r) {
    if (r < 0 || r > n) return 0;
    return fact[n] * invfact[r] % MOD * invfact[n - r] % MOD;
}

int* waysToFillArray(int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    init();
    int* res = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    for (int idx = 0; idx < queriesSize; idx++) {
        int n = queries[idx][0], k = queries[idx][1];
        long long ans = 1;
        int temp = k;
        for (int p = 2; p * p <= temp; p++) {
            if (temp % p == 0) {
                int cnt = 0;
                while (temp % p == 0) {
                    temp /= p;
                    cnt++;
                }
                ans = ans * nCr(n + cnt - 1, cnt) % MOD;
            }
        }
        if (temp > 1) {
            ans = ans * nCr(n, 1) % MOD;
        }
        res[idx] = ans;
    }
    return res;
}