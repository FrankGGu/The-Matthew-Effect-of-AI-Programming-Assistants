#include <stdio.h>
#include <stdlib.h>
#include <math.h>

long long mod = 1000000007;

long long pow_mod(long long base, long long exp) {
    long long result = 1;
    while (exp > 0) {
        if (exp % 2 == 1) {
            result = (result * base) % mod;
        }
        base = (base * base) % mod;
        exp /= 2;
    }
    return result;
}

long long maxNiceDivisors(int n) {
    if (n == 1) return 1;
    if (n == 2) return 2;
    if (n == 3) return 3;

    long long q = n / 3;
    long long r = n % 3;

    if (r == 0) {
        return pow_mod(3, q);
    } else if (r == 1) {
        return (pow_mod(3, q - 1) * 4) % mod;
    } else {
        return (pow_mod(3, q) * 2) % mod;
    }
}