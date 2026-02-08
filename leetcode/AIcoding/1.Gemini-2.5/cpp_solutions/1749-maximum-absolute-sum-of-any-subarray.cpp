#include <vector>
#include <algorithm>
#include <climits> // For INT_MIN, INT_MAX
#include <cmath>   // For std::abs

class Solution {
public:
    int maxAbsoluteSum(std::vector<int>& nums) {
        int current_max_sum = 0;
        int global_max_sum = INT_MIN;

        int current_min_sum = 0;
        int global_min_sum = INT_MAX;

        for (int num : nums) {
            current_max_sum += num;
            global_max_sum = std::max(global_max_sum, current_max_sum);
            if (current_max_sum < 0) {
                current_max_sum = 0;
            }

            current_min_sum += num;
            global_min_sum = std::min(global_min_sum, current_min_sum);
            if (current_min_sum > 0) {
                current_min_sum = 0;
            }
        }

        return std::max(std::abs(global_max_sum), std::abs(global_min_sum));
    }
};