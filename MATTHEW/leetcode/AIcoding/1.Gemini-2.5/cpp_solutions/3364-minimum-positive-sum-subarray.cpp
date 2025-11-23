#include <vector>
#include <set>
#include <numeric>
#include <algorithm>
#include <limits>

class Solution {
public:
    int minPositiveSumSubarray(std::vector<int>& nums) {
        long long min_positive_sum = std::numeric_limits<long long>::max();
        long long current_prefix_sum = 0;
        std::set<long long> prefix_sums_set;

        prefix_sums_set.insert(0);

        for (int num : nums) {
            current_prefix_sum += num;

            auto it = prefix_sums_set.lower_bound(current_prefix_sum);

            if (it != prefix_sums_set.begin()) {
                --it;
                long long val_j = *it;
                long long diff = current_prefix_sum - val_j;
                min_positive_sum = std::min(min_positive_sum, diff);
            }

            prefix_sums_set.insert(current_prefix_sum);
        }

        if (min_positive_sum == std::numeric_limits<long long>::max()) {
            return -1;
        } else {
            return static_cast<int>(min_positive_sum);
        }
    }
};