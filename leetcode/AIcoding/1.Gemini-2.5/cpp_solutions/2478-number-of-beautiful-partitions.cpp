#include <vector>
#include <string>
#include <numeric>

class Solution {
public:
    int beautifulPartitions(std::string s, int k, int minLength) {
        int n = s.length();
        long long MOD = 1e9 + 7;

        bool is_prime_char[10];
        std::fill(is_prime_char, is_prime_char + 10, false);
        is_prime_char[2] = is_prime_char[3] = is_prime_char[5] = is_prime_char[7] = true;

        auto is_prime = [&](char c) {
            return is_prime_char[c - '0'];
        };

        auto is_non_prime = [&](char c) {
            return !is_prime_char[c - '0'];
        };

        // Pre-checks for impossible cases
        if (!is_prime(s[0]) || !is_non_prime(s[n - 1])) {
            return 0;
        }
        if (n < k * minLength) {
            return 0;
        }

        // dp[i][j] = number of ways to partition s[0...i] into j beautiful partitions,
        // with the j-th partition ending at index i.
        std::vector<std::vector<long long>> dp(n, std::vector<long long>(k + 1, 0));

        // Base case: j = 1
        // The first partition must start at index 0.
        // s[0] must be prime (already checked globally).
        // s[i] must be non-prime.
        // Length (i + 1) must be at least minLength.
        for (int i = minLength - 1; i < n; ++i) {
            if (is_non_prime(s[i])) {
                dp[i][1] = 1;
            }
        }

        // DP transitions for j > 1
        for (int j = 2; j <= k; ++j) {
            // current_prefix_sum_dp_prev_j[p] stores sum(dp[x][j-1]) for x from 0 to p,
            // where s[x+1] is prime and x is a valid end index for (j-1) partitions.
            std::vector<long long> current_prefix_sum_dp_prev_j(n, 0);
            long long running_sum = 0;

            // Calculate prefix sums for dp[p][j-1]
            for (int p = 0; p < n; ++p) {
                // p must be a valid end index for (j-1) partitions.
                // This means p must be at least (j-1)*minLength - 1.
                // Also, s[p+1] must be a prime digit (as it's the start of the next partition).
                if (p >= (j - 1) * minLength - 1 && p + 1 < n && is_prime(s[p + 1])) {
                    running_sum = (running_sum + dp[p][j - 1]) % MOD;
                }
                current_prefix_sum_dp_prev_j[p] = running_sum;
            }

            // Calculate dp[i][j]
            for (int i = (j * minLength) - 1; i < n; ++i) {
                // The current (j-th) partition ends at index i.
                // s[i] must be a non-prime digit.
                if (is_non_prime(s[i])) {
                    // The previous partition (j-1) must end at index `prev_end_idx`.
                    // The current partition starts at `prev_end_idx + 1`.
                    // Length of current partition: `i - (prev_end_idx + 1) + 1 >= minLength`
                    // `i - prev_end_idx >= minLength`
                    // `prev_end_idx <= i - minLength`.
                    int upper_bound_p = i - minLength;

                    // The smallest valid `prev_end_idx` for (j-1) partitions is `(j-1)*minLength - 1`.
                    int lower_bound_p_effective = (j - 1) * minLength - 1;

                    long long sum_val = 0;
                    if (upper_bound_p >= lower_bound_p_effective && upper_bound_p >= 0) {
                        sum_val = current_prefix_sum_dp_prev_j[upper_bound_p];
                        if (lower_bound_p_effective > 0) {
                            sum_val = (sum_val - current_prefix_sum_dp_prev_j[lower_bound_p_effective - 1] + MOD) % MOD;
                        }
                    }
                    dp[i][j] = sum_val;
                }
            }
        }

        // Final answer: sum of dp[i][k] for all valid ending indices i.
        long long total_ways = 0;
        for (int i = (k * minLength) - 1; i < n; ++i) {
            total_ways = (total_ways + dp[i][k]) % MOD;
        }

        return total_ways;
    }
};