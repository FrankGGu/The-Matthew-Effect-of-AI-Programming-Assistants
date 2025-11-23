#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int sumOfFlooredPairs(std::vector<int>& nums) {
        long long MOD = 1e9 + 7;

        int max_val = *std::max_element(nums.begin(), nums.end());

        std::vector<long long> counts(max_val + 1, 0);
        for (int num : nums) {
            counts[num]++;
        }

        std::vector<long long> prefix_counts(max_val + 1, 0);
        for (int i = 1; i <= max_val; ++i) {
            prefix_counts[i] = prefix_counts[i - 1] + counts[i];
        }

        long long total_sum = 0;

        for (int y = 1; y <= max_val; ++y) {
            if (counts[y] == 0) {
                continue;
            }

            long long sum_for_y = 0;
            for (long long mult = y; mult <= max_val; mult += y) {
                long long k = mult / y;

                long long lower_bound = mult;
                long long upper_bound = std::min((long long)max_val, mult + y - 1);

                long long num_elements = prefix_counts[upper_bound] - prefix_counts[lower_bound - 1];

                long long term = (k * num_elements) % MOD;
                sum_for_y = (sum_for_y + term) % MOD;
            }

            long long term = (counts[y] * sum_for_y) % MOD;
            total_sum = (total_sum + term) % MOD;
        }

        return (int)total_sum;
    }
};