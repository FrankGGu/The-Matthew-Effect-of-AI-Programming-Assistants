#include <stdio.h>
#include <stdlib.h>
#include <math.h>

long long mod = 1000000007;

long long pow_mod(long long a, long long b) {
    long long result = 1;
    while (b > 0) {
        if (b % 2 == 1) {
            result = (result * a) % mod;
        }
        a = (a * a) % mod;
        b /= 2;
    }
    return result;
}

long long minNonZeroProduct(int n) {
    long long max_val = (1LL << n) - 1;
    long long k = (1LL << (n - 1)) - 1;
    long long product = pow_mod(max_val, k);
    product = (product * (max_val - 1)) % mod;
    return product;
}