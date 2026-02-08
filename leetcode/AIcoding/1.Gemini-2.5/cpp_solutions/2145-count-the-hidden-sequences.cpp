#include <vector>
#include <algorithm>

class Solution {
public:
    long long numberOfHiddenSequences(std::vector<int>& diff, int lower, int upper) {
        long long current_prefix_sum = 0;
        long long min_prefix_sum = 0;
        long long max_prefix_sum = 0;

        for (int d : diff) {
            current_prefix_sum += d;
            min_prefix_sum = std::min(min_prefix_sum, current_prefix_sum);
            max_prefix_sum = std::max(max_prefix_sum, current_prefix_sum);
        }

        long long lower_bound_b0 = lower - min_prefix_sum;
        long long upper_bound_b0 = upper - max_prefix_sum;

        if (upper_bound_b0 < lower_bound_b0) {
            return 0;
        }

        return upper_bound_b0 - lower_bound_b0 + 1;
    }
};