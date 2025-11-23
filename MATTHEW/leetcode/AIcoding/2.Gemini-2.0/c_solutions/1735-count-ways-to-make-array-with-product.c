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

long long modInverse(long long n) {
    return power(n, MOD - 2);
}

long long combinations(int n, int k) {
    if (k < 0 || k > n) return 0;
    if (k == 0 || k == n) return 1;
    if (k > n / 2) k = n - k;

    long long res = 1;
    for (int i = 1; i <= k; ++i) {
        res = (res * (n - i + 1)) % MOD;
        res = (res * modInverse(i)) % MOD;
    }
    return res;
}

int* waysToFillArray(int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int* result = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; ++i) {
        int n = queries[i][0];
        int k = queries[i][1];

        long long ans = 1;
        int num_factors = 0;
        int temp = k;
        for (int j = 2; j * j <= temp; ++j) {
            if (temp % j == 0) {
                num_factors++;
                while (temp % j == 0) {
                    temp /= j;
                }
            }
        }
        if (temp > 1) {
            num_factors++;
        }

        if (k == 1) {
            ans = 1;
        } else {
            temp = k;
            ans = combinations(n + num_factors - 1, num_factors - 1);
        }

        result[i] = (int)ans;
    }

    return result;
}