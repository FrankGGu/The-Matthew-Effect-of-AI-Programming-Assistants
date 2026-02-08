#include <vector>
#include <map>

const int MOD = 1000000007;

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

const int MAX_COMB_N = 200005; 
std::vector<long long> fact(MAX_COMB_N + 1);
std::vector<long long> invFact(MAX_COMB_N + 1);

void precompute_factorials() {
    fact[0] = 1;
    for (int i = 1; i <= MAX_COMB_N; i++) {
        fact[i] = (fact[i - 1] * i) % MOD;
    }
    invFact[MAX_COMB_N] = modInverse(fact[MAX_COMB_N]);
    for (int i = MAX_COMB_N - 1; i >= 0; i--) {
        invFact[i] = (invFact[i + 1] * (i + 1)) % MOD;
    }
}

long long nCr_mod_p(int n, int r) {
    if (r < 0 || r > n) return 0;
    return (((fact[n] * invFact[r]) % MOD) * invFact[n - r]) % MOD;
}

class Solution {
public:
    int waysToCreateProduct(int n, int k) {
        static bool precomputed = false;
        if (!precomputed) {
            precompute_factorials();
            precomputed = true;
        }

        std::map<int, int> prime_factors;
        int temp_n = n;
        for (int i = 2; i * i <= temp_n; ++i) {
            while (temp_n % i == 0) {
                prime_factors[i]++;
                temp_n /= i;
            }
        }
        if (temp_n > 1) {
            prime_factors[temp_n]++;
        }

        long long total_ways = 1;
        for (auto const& [prime, exponent] : prime_factors) {
            total_ways = (total_ways * nCr_mod_p(exponent + k - 1, k - 1)) % MOD;
        }

        return total_ways;
    }
};