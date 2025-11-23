#include <vector>
#include <numeric>
#include <cmath>
#include <limits>

class Solution {
public:
    int minimumAverageDifference(std::vector<int>& nums) {
        int n = nums.size();

        long long total_sum = 0;
        for (int num : nums) {
            total_sum += num;
        }

        long long min_avg_diff = std::numeric_limits<long long>::max();
        int result_index = -1;

        long long current_prefix_sum = 0;

        for (int i = 0; i < n; ++i) {
            current_prefix_sum += nums[i];

            long long avg_left = current_prefix_sum / (i + 1);

            long long avg_right;
            long long remaining_elements_count = n - (i + 1);

            if (remaining_elements_count == 0) {
                avg_right = 0;
            } else {
                long long current_suffix_sum = total_sum - current_prefix_sum;
                avg_right = current_suffix_sum / remaining_elements_count;
            }

            long long current_diff = std::abs(avg_left - avg_right);

            if (current_diff < min_avg_diff) {
                min_avg_diff = current_diff;
                result_index = i;
            }
        }

        return result_index;
    }
};