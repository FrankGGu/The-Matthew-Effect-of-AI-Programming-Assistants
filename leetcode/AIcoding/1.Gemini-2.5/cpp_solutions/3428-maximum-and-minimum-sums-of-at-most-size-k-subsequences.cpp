#include <vector>
#include <algorithm>
#include <numeric>

class Solution {
public:
    std::vector<long long> maximumAndMinimumSums(std::vector<int>& nums, int k) {
        std::sort(nums.begin(), nums.end());
        int n = nums.size();

        long long max_sum = 0;
        bool has_positive_for_max = false;
        for (int i = 0; i < k; ++i) {
            if (nums[n - 1 - i] > 0) {
                max_sum += nums[n - 1 - i];
                has_positive_for_max = true;
            }
        }
        if (!has_positive_for_max) {
            max_sum = nums[n - 1];
        }

        long long min_sum = 0;
        bool has_negative_for_min = false;
        for (int i = 0; i < k; ++i) {
            if (nums[i] < 0) {
                min_sum += nums[i];
                has_negative_for_min = true;
            }
        }
        if (!has_negative_for_min) {
            min_sum = nums[0];
        }

        return {max_sum, min_sum};
    }
};