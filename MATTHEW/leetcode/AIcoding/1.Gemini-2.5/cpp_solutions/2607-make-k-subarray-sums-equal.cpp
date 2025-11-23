#include <vector>
#include <numeric>
#include <algorithm>
#include <cmath> // For std::abs

class Solution {
public:
    long long makeSubKSumEqual(std::vector<int>& nums, int k) {
        int n = nums.size();
        long long total_operations = 0;

        for (int j = 0; j < k; ++j) {
            std::vector<int> group_elements;
            for (int idx = j; idx < n; idx += k) {
                group_elements.push_back(nums[idx]);
            }

            if (group_elements.empty()) {
                continue;
            }

            std::sort(group_elements.begin(), group_elements.end());

            int median = group_elements[group_elements.size() / 2];

            for (int val : group_elements) {
                total_operations += std::abs(static_cast<long long>(val) - median);
            }
        }

        return total_operations;
    }
};