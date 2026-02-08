#include <vector>
#include <numeric>
#include <algorithm>
#include <bitset>

const int MAX_N_VAL = 100000; 
std::vector<bool> is_prime_sieve_global(MAX_N_VAL + 1, true);
std::vector<int> primes_list_global;
bool sieve_initialized = false;

void init_sieve() {
    if (sieve_initialized) return;

    is_prime_sieve_global[0] = is_prime_sieve_global[1] = false;
    for (int p = 2; p * p <= MAX_N_VAL; ++p) {
        if (is_prime_sieve_global[p]) {
            for (int i = p * p; i <= MAX_N_VAL; i += p)
                is_prime_sieve_global[i] = false;
        }
    }
    for (int p = 2; p <= MAX_N_VAL; ++p) {
        if (is_prime_sieve_global[p]) {
            primes_list_global.push_back(p);
        }
    }
    sieve_initialized = true;
}

std::bitset<MAX_N_VAL + 1> get_prime_factors_bs(int num) {
    std::bitset<MAX_N_VAL + 1> factors_bs;
    if (num <= 1) return factors_bs;

    // Iterate through precomputed primes
    for (int p : primes_list_global) {
        if (p * p > num) break; // Optimization: only check primes up to sqrt(num)
        if (num % p == 0) {
            factors_bs[p] = 1; // Mark p as a prime factor
            while (num % p == 0) {
                num /= p; // Remove all occurrences of p
            }
        }
    }
    // If num is still greater than 1, it must be a prime factor itself
    if (num > 1) { 
        factors_bs[num] = 1;
    }
    return factors_bs;
}

class Solution {
public:
    int maximizeDistinctPrimes(int n) {
        init_sieve(); // Ensure sieve is initialized once for all test cases

        int max_distinct_primes_count = 0;

        // According to problem constraints, a and b must be positive integers.
        // Thus, n must be at least 2 for a valid split.
        if (n < 2) return 0; 

        // Iterate through all possible splits of n into two positive integers a and b.
        // a ranges from 1 to n-1. b is then n-a.
        for (int a = 1; a < n; ++a) {
            int b = n - a;

            // Get distinct prime factors for a and b using bitsets.
            std::bitset<MAX_N_VAL + 1> factors_a_bs = get_prime_factors_bs(a);
            std::bitset<MAX_N_VAL + 1> factors_b_bs = get_prime_factors_bs(b);

            // Combine the prime factors of a and b using bitwise OR.
            // The resulting bitset will have a '1' for any prime that divides a or b.
            std::bitset<MAX_N_VAL + 1> combined_factors_bs = factors_a_bs | factors_b_bs;

            // Update the maximum count of distinct primes found so far.
            max_distinct_primes_count = std::max(max_distinct_primes_count, (int)combined_factors_bs.count());
        }
        return max_distinct_primes_count;
    }
};