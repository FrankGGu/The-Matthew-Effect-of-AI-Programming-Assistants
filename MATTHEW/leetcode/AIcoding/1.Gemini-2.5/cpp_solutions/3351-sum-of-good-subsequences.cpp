#include <vector>
#include <map>
#include <cmath>
#include <algorithm>

class Solution {
public:
    int sumOfGoodSubsequences(std::vector<int>& nums) {
        long long MOD = 1e9 + 7;

        // dp[val] stores pair<sum_of_values_ending_with_val, count_of_subsequences_ending_with_val>
        // for all good subsequences ending with 'val' that have been processed so far.
        std::map<int, std::pair<long long, long long>> dp;
        long long total_sum = 0;

        for (int num : nums) {
            long long current_subsequence_sum = num; // For the subsequence consisting only of 'num'
            long long current_subsequence_count = 1; // For the subsequence consisting only of 'num'

            // Case 1: Extend subsequences ending with 'prev_val' where 'num' is a multiple of 'prev_val'.
            // i.e., prev_val is a divisor of num. (nums[sub[i+1]] % nums[sub[i]] == 0)
            for (int d = 1; d * d <= num; ++d) {
                if (num % d == 0) {
                    // d is a divisor of num
                    if (dp.count(d)) {
                        current_subsequence_sum = (current_subsequence_sum + dp[d].first + dp[d].second * num) % MOD;
                        current_subsequence_count = (current_subsequence_count + dp[d].second) % MOD;
                    }

                    // num/d is also a divisor of num
                    int d2 = num / d;
                    if (d2 != d && dp.count(d2)) {
                        current_subsequence_sum = (current_subsequence_sum + dp[d2].first + dp[d2].second * num) % MOD;
                        current_subsequence_count = (current_subsequence_count + dp[d2].second) % MOD;
                    }
                }
            }

            // Case 2: Extend subsequences ending with 'prev_val' where 'prev_val' is a multiple of 'num'.
            // i.e., prev_val is a multiple of num. (nums[sub[i]] % nums[sub[i+1]] == 0)
            // Iterate through all distinct values seen so far (keys in dp map).
            // If a value 'prev_val' is a multiple of 'num', it can precede 'num'.
            for (auto const& [prev_val, prev_dp_pair] : dp) {
                if (prev_val % num == 0) {
                    current_subsequence_sum = (current_subsequence_sum + prev_dp_pair.first + prev_dp_pair.second * num) % MOD;
                    current_subsequence_count = (current_subsequence_count + prev_dp_pair.second) % MOD;
                }
            }

            // Update dp entry for 'num' by adding the newly formed subsequences.
            dp[num].first = (dp[num].first + current_subsequence_sum) % MOD;
            dp[num].second = (dp[num].second + current_subsequence_count) % MOD;

            // Add the sum of values of these new subsequences to the total sum.
            total_sum = (total_sum + current_subsequence_sum) % MOD;
        }

        return static_cast<int>(total_sum);
    }
};