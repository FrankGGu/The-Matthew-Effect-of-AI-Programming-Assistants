#include <vector>
#include <numeric>
#include <algorithm>
#include <limits>

class Solution {
public:
    int maxSubarraySumCircular(std::vector<int>& nums) {
        int n = nums.size();

        int max_so_far = nums[0];
        int current_max = nums[0];
        int min_so_far = nums[0];
        int current_min = nums[0];
        int total_sum = nums[0];

        for (int i = 1; i < n; ++i) {
            total_sum += nums[i];

            current_max = std::max(nums[i], current_max + nums[i]);
            max_so_far = std::max(max_so_far, current_max);

            current_min = std::min(nums[i], current_min + nums[i]);
            min_so_far = std::min(min_so_far, current_min);
        }

        if (max_so_far < 0) {
            return max_so_far;
        } else {
            return std::max(max_so_far, total_sum - min_so_far);
        }
    }
};