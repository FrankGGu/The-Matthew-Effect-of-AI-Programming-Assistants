#include <vector>
#include <algorithm>
#include <limits>

class Solution {
public:
    int minimumSum(std::vector<int>& nums) {
        int n = nums.size();
        if (n < 3) {
            return -1;
        }

        std::vector<int> prefix_min(n);
        prefix_min[0] = nums[0];
        for (int i = 1; i < n; ++i) {
            prefix_min[i] = std::min(prefix_min[i - 1], nums[i]);
        }

        std::vector<int> suffix_min(n);
        suffix_min[n - 1] = nums[n - 1];
        for (int i = n - 2; i >= 0; --i) {
            suffix_min[i] = std::min(suffix_min[i + 1], nums[i]);
        }

        long long min_sum = std::numeric_limits<long long>::max();

        for (int j = 1; j < n - 1; ++j) {
            int left_val = prefix_min[j - 1];
            int right_val = suffix_min[j + 1];

            if (left_val < nums[j] && right_val < nums[j]) {
                min_sum = std::min(min_sum, (long long)left_val + nums[j] + right_val);
            }
        }

        if (min_sum == std::numeric_limits<long long>::max()) {
            return -1;
        } else {
            return static_cast<int>(min_sum);
        }
    }
};