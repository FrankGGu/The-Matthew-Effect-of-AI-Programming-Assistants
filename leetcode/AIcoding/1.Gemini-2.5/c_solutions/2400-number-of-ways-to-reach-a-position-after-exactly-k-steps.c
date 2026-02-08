#include <stdlib.h> // For abs, though manual abs for long long is used

long long MOD = 1e9 + 7;

long long fact[1001]; // Max k is 1000
long long invFact[1001];

int precomputed = 0;

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

void precompute_factorials(int max_k) {
    fact[0] = 1;
    for (int i = 1; i <= max_k; i++) {
        fact[i] = (fact[i - 1] * i) % MOD;
    }

    // Compute inverse factorials using invFact[n] = (n!)^(-1) and invFact[i-1] = invFact[i] * i
    invFact[max_k] = modInverse(fact[max_k]);
    for (int i = max_k - 1; i >= 0; i--) { // Iterate down to 0 for invFact[0]
        invFact[i] = (invFact[i + 1] * (i + 1)) % MOD;
    }
}

long long nCr_mod_p(int n, int r) {
    if (r < 0 || r > n) return 0;
    return (((fact[n] * invFact[r]) % MOD) * invFact[n - r]) % MOD;
}

int numberOfWays(int startPos, int endPos, int k) {
    if (!precomputed) {
        precompute_factorials(1000);
        precomputed = 1;
    }

    long long diff = (long long)endPos - startPos;
    long long abs_diff = diff > 0 ? diff : -diff; // Manual abs for long long

    // Conditions for reaching endPos in k steps:
    // 1. The absolute difference between start and end position must not exceed k.
    // 2. The parity of the difference (endPos - startPos) must be the same as the parity of k.
    //    This is equivalent to (k - abs_diff) being an even number.
    if (abs_diff > k || (k - abs_diff) % 2 != 0) {
        return 0;
    }

    // Let 'x' be the number of steps to the right and 'y' be the number of steps to the left.
    // We have:
    // x + y = k (total steps)
    // startPos + x - y = endPos (final position)
    //
    // From these equations, we can solve for x:
    // x - y = endPos - startPos
    // x + y = k
    // Adding the two equations: 2x = k + (endPos - startPos)
    // x = (k + (endPos - startPos)) / 2

    long long num_right_steps = (k + diff) / 2;

    // The number of ways is C(k, x), choosing 'x' right steps out of 'k' total steps.
    return (int)nCr_mod_p(k, (int)num_right_steps);
}