#include <stdint.h> // For long long

long long power(long long base, long long exp, long long mod) {
    long long res = 1;
    base %= mod;
    while (exp > 0) {
        if (exp % 2 == 1) {
            res = (res * base) % mod;
        }
        base = (base * base) % mod;
        exp /= 2;
    }
    return res;
}

int minNonZeroProduct(int p) {
    long long MOD = 1e9 + 7;

    // The exponent for the final result (2^X mod MOD) is (2^(p-1) - 1).
    // This exponent itself can be very large, so we need to calculate it modulo (MOD - 1).
    // By Fermat's Little Theorem, a^b % M = a^(b % (M-1)) % M for prime M and a not multiple of M.
    // Here, M = 10^9 + 7 is prime.

    // Calculate (2^(p-1)) % (MOD - 1)
    long long exponent_base = 2;
    long long exponent_power = p - 1;
    long long mod_for_exponent = MOD - 1;

    long long actual_exponent_val;
    if (exponent_power < 0) { // Should not happen given p >= 1
        actual_exponent_val = 0;
    } else {
        actual_exponent_val = power(exponent_base, exponent_power, mod_for_exponent);
    }

    // The actual exponent for the final answer is (2^(p-1) - 1).
    // So, we subtract 1 from actual_exponent_val.
    // Ensure the result is positive before taking modulo.
    actual_exponent_val = (actual_exponent_val - 1 + mod_for_exponent) % mod_for_exponent;

    // Calculate the final result: 2^(actual_exponent_val) % MOD
    long long result = power(2, actual_exponent_val, MOD);

    return (int)result;
}