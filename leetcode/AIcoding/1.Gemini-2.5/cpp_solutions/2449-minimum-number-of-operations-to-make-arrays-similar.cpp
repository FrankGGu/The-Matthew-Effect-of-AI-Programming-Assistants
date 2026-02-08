#include <vector>
#include <algorithm>
#include <cmath> // For std::abs

class Solution {
public:
    long long minimumOperations(std::vector<int>& nums, std::vector<int>& target) {
        std::vector<int> nums_even;
        std::vector<int> nums_odd;
        std::vector<int> target_even;
        std::vector<int> target_odd;

        for (int num : nums) {
            if (num % 2 == 0) {
                nums_even.push_back(num);
            } else {
                nums_odd.push_back(num);
            }
        }

        for (int num : target) {
            if (num % 2 == 0) {
                target_even.push_back(num);
            } else {
                target_odd.push_back(num);
            }
        }

        std::sort(nums_even.begin(), nums_even.end());
        std::sort(nums_odd.begin(), nums_odd.end());
        std::sort(target_even.begin(), target_even.end());
        std::sort(target_odd.begin(), target_odd.end());

        long long total_abs_diff = 0;

        for (size_t i = 0; i < nums_even.size(); ++i) {
            total_abs_diff += std::abs(static_cast<long long>(nums_even[i]) - target_even[i]);
        }

        for (size_t i = 0; i < nums_odd.size(); ++i) {
            total_abs_diff += std::abs(static_cast<long long>(nums_odd[i]) - target_odd[i]);
        }

        return total_abs_diff / 4;
    }
};