#include <vector>
#include <numeric>
#include <algorithm>
#include <cmath>

class Solution {
public:
    int minAbsDifference(std::vector<int>& nums, int goal) {
        int n = nums.size();
        int mid = n / 2;

        std::vector<int> left_sums;
        left_sums.push_back(0);
        for (int i = 0; i < mid; ++i) {
            int current_size = left_sums.size();
            for (int j = 0; j < current_size; ++j) {
                left_sums.push_back(left_sums[j] + nums[i]);
            }
        }

        std::vector<int> right_sums;
        right_sums.push_back(0);
        for (int i = mid; i < n; ++i) {
            int current_size = right_sums.size();
            for (int j = 0; j < current_size; ++j) {
                right_sums.push_back(right_sums[j] + nums[i]);
            }
        }

        std::sort(left_sums.begin(), left_sums.end());
        left_sums.erase(std::unique(left_sums.begin(), left_sums.end()), left_sums.end());

        std::sort(right_sums.begin(), right_sums.end());
        right_sums.erase(std::unique(right_sums.begin(), right_sums.end()), right_sums.end());

        int min_diff = std::abs(goal);
        int i = 0;
        int j = right_sums.size() - 1;

        while (i < left_sums.size() && j >= 0) {
            long long current_sum = (long long)left_sums[i] + right_sums[j];
            min_diff = std::min(min_diff, (int)std::abs(current_sum - goal));

            if (current_sum == goal) {
                return 0;
            } else if (current_sum < goal) {
                i++;
            } else {
                j--;
            }
        }

        return min_diff;
    }
};