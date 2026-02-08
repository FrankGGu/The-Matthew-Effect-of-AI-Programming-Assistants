#include <vector>

class Solution {
public:
    long long power(long long base, long long exp) {
        long long res = 1;
        long long MOD = 1000000007;
        base %= MOD;
        while (exp > 0) {
            if (exp % 2 == 1) res = (res * base) % MOD;
            base = (base * base) % MOD;
            exp /= 2;
        }
        return res;
    }

    long long modInverse(long long n) {
        long long MOD = 1000000007;
        return power(n, MOD - 2);
    }

    int valueAfterKSeconds(int n, int k) {
        long long MOD = 1000000007;

        // The problem asks for a[n-1] after k seconds.
        // This value is equivalent to C(k + n - 1, k) or C(k + n - 1, n - 1).
        // We will calculate C(N, K) = N! / (K! * (N-K)!) mod MOD
        // Here, N = k + n - 1
        // K = k
        // N-K = (k + n - 1) - k = n - 1

        long long N_val = k + n - 1;
        long long K_val = k;
        long long NK_val = n - 1;

        // Precompute factorials up to N_val
        std::vector<long long> fact(N_val + 1);
        fact[0] = 1;
        for (int i = 1; i <= N_val; i++) {
            fact[i] = (fact[i - 1] * i) % MOD;
        }

        long long numerator = fact[N_val];
        long long denominator = (fact[K_val] * fact[NK_val]) % MOD;

        long long result = (numerator * modInverse(denominator)) % MOD;

        return static_cast<int>(result);
    }
};