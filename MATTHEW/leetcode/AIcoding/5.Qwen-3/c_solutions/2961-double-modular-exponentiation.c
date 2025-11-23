#include <stdio.h>
#include <stdlib.h>
#include <math.h>

long long mod_pow(long long base, long long exp, long long mod) {
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

long long double_modular_exponentiation(long long a, long long b, long long c, long long d, long long m) {
    long long part1 = mod_pow(a, b, m);
    long long part2 = mod_pow(c, d, m);
    return (part1 * part2) % m;
}