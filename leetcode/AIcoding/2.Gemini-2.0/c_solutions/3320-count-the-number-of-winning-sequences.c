#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countTheNumberofWinningSequences(int n, int* hits, int hitsSize, int k) {
    int mod = 1e9 + 7;
    long long fact[n + 1];
    fact[0] = 1;
    for (int i = 1; i <= n; i++) {
        fact[i] = (fact[i - 1] * i) % mod;
    }

    long long power(long long base, long long exp) {
        long long res = 1;
        base %= mod;
        while (exp > 0) {
            if (exp % 2 == 1) res = (res * base) % mod;
            base = (base * base) % mod;
            exp /= 2;
        }
        return res;
    }

    long long modInverse(long long n) {
        return power(n, mod - 2);
    }

    long long combinations(int n, int r) {
        if (r < 0 || r > n) return 0;
        long long numerator = fact[n];
        long long denominator = (fact[r] * fact[n - r]) % mod;
        return (numerator * modInverse(denominator)) % mod;
    }

    int count[1001] = {0};
    for (int i = 0; i < hitsSize; i++) {
        count[hits[i]]++;
    }

    int distinct = 0;
    for (int i = 1; i <= 1000; i++) {
        if (count[i] > 0) {
            distinct++;
        }
    }

    long long ans = 1;
    int available = n;
    for (int i = 1; i <= 1000; i++) {
        if (count[i] > 0) {
            if (available < count[i]) return 0;
            ans = (ans * combinations(available, count[i])) % mod;
            available -= count[i];
        }
    }

    ans = (ans * fact[n]) % mod;

    for (int i = 1; i <= 1000; i++) {
        if (count[i] > 0) {
            ans = (ans * modInverse(fact[count[i]])) % mod;
        }
    }

    return (int)ans;
}