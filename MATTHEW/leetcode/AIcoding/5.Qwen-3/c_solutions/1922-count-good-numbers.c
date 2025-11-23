#include <stdio.h>
#include <stdlib.h>

long long pow_mod(long long base, long long exp, long long mod) {
    long long result = 1;
    base = base % mod;
    while (exp > 0) {
        if (exp % 2 == 1) {
            result = (result * base) % mod;
        }
        base = (base * base) % mod;
        exp = exp / 2;
    }
    return result;
}

long long countGoodNumbers(long long n) {
    long long mod = 1000000007;
    long long even_count = pow_mod(5, n / 2 + n % 2, mod);
    long long odd_count = pow_mod(4, n / 2, mod);
    return (even_count * odd_count) % mod;
}