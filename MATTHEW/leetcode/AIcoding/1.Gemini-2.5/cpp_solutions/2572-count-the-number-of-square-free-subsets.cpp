#include <vector>
#include <numeric>

class Solution {
private:
    static std::vector<int> prime_list;
    static int prime_to_idx[31];
    static std::vector<int> masks;
    static bool precomputed;
    static const int MOD = 1e9 + 7;

    static void precompute_data() {
        if (precomputed) return;

        prime_list = {2, 3, 5, 7, 11, 13, 17, 19, 23, 29};

        for (int i = 0; i < prime_list.size(); ++i) {
            prime_to_idx[prime_list[i]] = i;
        }

        masks.resize(31);
        masks[1] = 0; // 1 is square-free, product of no primes (empty set of prime factors)

        for (int i = 2; i <= 30; ++i) {
            int temp_mask = 0;
            int num = i;
            bool is_sf = true;
            for (int p : prime_list) {
                if (num % p == 0) {
                    int count = 0;
                    while (num % p == 0) {
                        num /= p;
                        count++;
                    }
                    if (count > 1) { // Not square-free (e.g., 4, 8, 9, 12, etc.)
                        is_sf = false;
                        break;
                    }
                    temp_mask |= (1 << prime_to_idx[p]);
                }
            }

            if (is_sf) {
                masks[i] = temp_mask;
            } else {
                masks[i] = -1; // Mark as not square-free
            }
        }
        precomputed = true;
    }

public:
    int squareFreeSubsets(std::vector<int>& nums) {
        precompute_data();

        std::vector<long long> dp(1 << prime_list.size(), 0);
        dp[0] = 1; // Base case: empty subset, product 1, which is square-free

        int count_ones = 0;
        for (int num : nums) {
            if (num == 1) {
                count_ones++;
                continue;
            }

            int current_mask = masks[num];
            if (current_mask == -1) { // Not square-free
                continue;
            }

            // Iterate masks in reverse to avoid using the current number multiple times
            // in the same iteration for different subsets.
            // This ensures that when we update dp[prev_mask | current_mask],
            // dp[prev_mask] is from the previous state (before considering the current num).
            for (int prev_mask = (1 << prime_list.size()) - 1; prev_mask >= 0; --prev_mask) {
                if (dp[prev_mask] > 0) {
                    // If current_mask shares no common prime factors with prev_mask
                    if ((prev_mask & current_mask) == 0) {
                        dp[prev_mask | current_mask] = (dp[prev_mask | current_mask] + dp[prev_mask]) % MOD;
                    }
                }
            }
        }

        long long total_subsets = 0;
        for (long long count : dp) {
            total_subsets = (total_subsets + count) % MOD;
        }

        // For each '1' in nums, it can either be included or excluded in any existing
        // square-free subset without changing its product's square-freeness or prime factors.
        // If there are 'k' ones, each existing square-free subset can be combined with 2^k ways
        // of choosing the ones. This effectively multiplies the total count by 2^k.
        for (int i = 0; i < count_ones; ++i) {
            total_subsets = (total_subsets * 2) % MOD;
        }

        return total_subsets;
    }
};

std::vector<int> Solution::prime_list;
int Solution::prime_to_idx[31];
std::vector<int> Solution::masks;
bool Solution::precomputed = false;