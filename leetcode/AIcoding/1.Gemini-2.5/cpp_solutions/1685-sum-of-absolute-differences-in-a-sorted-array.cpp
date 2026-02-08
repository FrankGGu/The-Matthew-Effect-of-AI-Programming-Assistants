#include <vector>
#include <numeric>

class Solution {
public:
    std::vector<long long> getSumAbsoluteDifferences(std::vector<int>& nums) {
        int n = nums.size();
        std::vector<long long> result(n);

        std::vector<long long> prefix_sums(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix_sums[i + 1] = prefix_sums[i] + nums[i];
        }

        for (int i = 0; i < n; ++i) {
            long long current_num = nums[i];

            long long left_count = i;
            long long left_sum_elements = prefix_sums[i];
            long long diff_left = left_count * current_num - left_sum_elements;

            long long right_count = n - 1 - i;
            long long right_sum_elements = prefix_sums[n] - prefix_sums[i + 1];
            long long diff_right = right_sum_elements - right_count * current_num;

            result[i] = diff_left + diff_right;
        }

        return result;
    }
};