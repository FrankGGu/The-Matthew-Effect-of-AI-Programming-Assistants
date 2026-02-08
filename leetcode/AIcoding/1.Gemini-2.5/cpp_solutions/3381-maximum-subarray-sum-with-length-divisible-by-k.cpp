#include <vector>
#include <numeric>
#include <algorithm>
#include <limits>

class Solution {
public:
    long long maximumSubarraySum(std::vector<int>& nums, int k) {
        long long current_prefix_sum = 0;
        std::vector<long long> min_prefix_sum_at_remainder(k, std::numeric_limits<long long>::max());

        min_prefix_sum_at_remainder[0] = 0;

        long long max_sum = std::numeric_limits<long long>::min();

        for (int i = 0; i < nums.size(); ++i) {
            current_prefix_sum += nums[i];

            int remainder = (i + 1) % k;

            if (min_prefix_sum_at_remainder[remainder] != std::numeric_limits<long long>::max()) {
                max_sum = std::max(max_sum, current_prefix_sum - min_prefix_sum_at_remainder[remainder]);
            }

            min_prefix_sum_at_remainder[remainder] = std::min(min_prefix_sum_at_remainder[remainder], current_prefix_sum);
        }

        return max_sum;
    }
};