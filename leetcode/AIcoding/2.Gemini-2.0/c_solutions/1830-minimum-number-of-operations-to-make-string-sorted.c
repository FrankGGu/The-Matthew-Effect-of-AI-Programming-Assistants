#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007

long long factorial(int n, long long fact[]) {
    if (fact[n] != -1) {
        return fact[n];
    }
    if (n == 0 || n == 1) {
        fact[n] = 1;
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

int string_cmp(const void *a, const void *b) {
    return *(char *)a - *(char *)b;
}

int makeStringSorted(char * s){
    int n = strlen(s);
    long long fact[n + 1];
    for (int i = 0; i <= n; i++) {
        fact[i] = -1;
    }
    factorial(n, fact);

    long long ans = 0;
    for (int i = 0; i < n; i++) {
        int smaller = 0;
        int counts[26] = {0};
        for (int j = i + 1; j < n; j++) {
            counts[s[j] - 'a']++;
            if (s[j] < s[i]) {
                smaller++;
            }
        }

        long long denominator = 1;
        for (int j = 0; j < 26; j++) {
            if (counts[j] > 1) {
                denominator = (denominator * fact[counts[j]]) % MOD;
            }
        }

        long long numerator = fact[n - i - 1];
        long long inverseDenominator = modInverse(denominator);

        long long permutations = (numerator * inverseDenominator) % MOD;

        ans = (ans + (smaller * permutations) % MOD) % MOD;
    }

    return (int)ans;
}