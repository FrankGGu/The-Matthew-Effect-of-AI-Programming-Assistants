#include <vector>
#include <numeric>
#include <map>

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

    int numberOfGoodSubsets(std::vector<int>& nums) {
        const int MOD = 1000000007;

        std::vector<int> counts(31, 0);
        for (int num : nums) {
            counts[num]++;
        }

        std::vector<int> primes = {2, 3, 5, 7, 11, 13, 17, 19, 23, 29};
        std::map<int, int> prime_to_idx;
        for (int i = 0; i < primes.size(); ++i) {
            prime_to_idx[primes[i]] = i;
        }

        std::vector<int> prime_masks(31, 0);
        std::vector<bool> is_square_free(31, true);

        for (int i = 2; i <= 30; ++i) {
            int temp_i = i;
            for (int p : primes) {
                if (temp_i % p == 0) {
                    prime_masks[i] |= (1 << prime_to_idx[p]);
                    temp_i /= p;
                    if (temp_i % p == 0) { // Contains p*p factor, not square-free
                        is_square_free[i] = false;
                        break;
                    }
                }
            }
        }

        std::vector<long long> dp(1 << primes.size(), 0);
        dp[0] = 1; // Represents the empty set, product 1, which is square-free

        for (int i = 2; i <= 30; ++i) {
            if (counts[i] == 0 || !is_square_free[i]) {
                continue;
            }

            int current_num_mask = prime_masks[i];
            for (int mask = (1 << primes.size()) - 1; mask >= 0; --mask) {
                if ((mask & current_num_mask) == 0) { // If current number's prime factors don't overlap with mask
                    dp[mask | current_num_mask] = (dp[mask | current_num_mask] + dp[mask] * counts[i]) % MOD;
                }
            }
        }

        long long total_good_subsets_from_2_to_30 = 0;
        for (int mask = 0; mask < (1 << primes.size()); ++mask) {
            total_good_subsets_from_2_to_30 = (total_good_subsets_from_2_to_30 + dp[mask]) % MOD;
        }

        // The total_good_subsets_from_2_to_30 includes the empty set (dp[0]).
        // Each good subset (including the empty set) can be combined with any number of '1's.
        // If there are 'counts[1]' occurrences of '1', there are 2^counts[1] ways to choose '1's.
        long long ans = (total_good_subsets_from_2_to_30 * power(2, counts[1])) % MOD;

        // The problem usually implies non-empty subsets for "number of subsets".
        // The empty set is a good subset (product is 1). If it should be excluded, subtract 1.
        // For example: nums = [1]. Good subsets are {} and {1}. Count is 2.
        // Our current logic: dp[0]=1. total_good_subsets_from_2_to_30 = 1. power(2, counts[1]) = power(2,1) = 2. ans = 1*2 = 2.
        // This matches. So, no subtraction needed, the empty set is counted.

        return ans;
    }
};