#include <vector>
#include <numeric>

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

const int MAX_COMB_N = 10000 + 15; 
std::vector<long long> fact;
std::vector<long long> invFact;

void precompute_factorials(int max_val) {
    long long MOD = 1000000007;
    fact.resize(max_val + 1);
    invFact.resize(max_val + 1);
    fact[0] = 1;
    invFact[0] = 1;
    for (int i = 1; i <= max_val; i++) {
        fact[i] = (fact[i - 1] * i) % MOD;
        invFact[i] = modInverse(fact[i]);
    }
}

long long nCr_mod_p(int n_val, int r_val) {
    long long MOD = 1000000007;
    if (r_val < 0 || r_val > n_val) return 0;
    // C(N, K) = N! / (K! * (N-K)!)
    // In this problem, N = (exponent + array_length - 1) and K = exponent.
    // So n_val is (exponent + array_length - 1) and r_val is exponent.
    return (((fact[n_val] * invFact[r_val]) % MOD) * invFact[n_val - r_val]) % MOD;
}

class Solution {
public:
    int idealArrays(int n, int maxValue) {
        // Precompute factorials only once when the program starts or the first test case runs.
        if (fact.empty()) {
            precompute_factorials(MAX_COMB_N);
        }

        long long total_ideal_arrays = 0;
        long long MOD = 1000000007;

        // Iterate through each possible last element 'j' of an ideal array.
        // For each 'j', count the number of ways to form an ideal array of length 'n' ending with 'j'.
        for (int j = 1; j <= maxValue; ++j) {
            long long current_ways_for_j = 1;
            int temp_j = j;

            // Prime factorization of 'j'.
            // If j = p1^e1 * p2^e2 * ... * pk^ek, then the number of ways to form
            // an ideal array of length n ending with j is product(C(ei + n - 1, ei)) for each prime factor pi.
            for (int p = 2; p * p <= temp_j; ++p) {
                if (temp_j % p == 0) {
                    int count_p_exp = 0;
                    while (temp_j % p == 0) {
                        count_p_exp++;
                        temp_j /= p;
                    }
                    // Calculate C(count_p_exp + n - 1, count_p_exp) for this prime factor.
                    current_ways_for_j = (current_ways_for_j * nCr_mod_p(count_p_exp + n - 1, count_p_exp)) % MOD;
                }
            }
            // If temp_j > 1 after the loop, it means temp_j itself is a prime factor.
            if (temp_j > 1) {
                int count_p_exp = 1; // Its exponent is 1
                current_ways_for_j = (current_ways_for_j * nCr_mod_p(count_p_exp + n - 1, count_p_exp)) % MOD;
            }
            total_ideal_arrays = (total_ideal_arrays + current_ways_for_j) % MOD;
        }

        return static_cast<int>(total_ideal_arrays);
    }
};