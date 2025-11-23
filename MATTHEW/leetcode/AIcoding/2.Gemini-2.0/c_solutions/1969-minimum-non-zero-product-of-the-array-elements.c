#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long power(long long base, long long exp, long long mod) {
    long long res = 1;
    base %= mod;
    while (exp > 0) {
        if (exp % 2 == 1) res = (res * base) % mod;
        base = (base * base) % mod;
        exp /= 2;
    }
    return res;
}

int minNonZeroProduct(int p) {
    long long mod = 1000000007;
    long long max_val = (1LL << p) - 1;
    long long num_pairs = (max_val - 1) / 2;
    long long result = power(max_val - 1, num_pairs, mod);
    result = (result * max_val) % mod;
    return (int)result;
}