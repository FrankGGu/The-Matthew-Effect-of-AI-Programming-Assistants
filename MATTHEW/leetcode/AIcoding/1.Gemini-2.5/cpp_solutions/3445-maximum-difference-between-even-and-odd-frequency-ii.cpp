#include <vector>
#include <numeric>
#include <algorithm>
#include <cmath>

class Solution {
public:
    int maxAbsoluteSum(const std::vector<int>& nums) {
        if (nums.empty()) {
            return 0;
        }

        std::vector<int> arr(nums.size());
        for (size_t i = 0; i < nums.size(); ++i) {
            if (nums[i] % 2 == 0) {
                arr[i] = -1; // Even numbers contribute -1 to the sum
            } else {
                arr[i] = 1;  // Odd numbers contribute 1 to the sum
            }
        }

        // Kadane's algorithm to find the maximum subarray sum
        int max_sum = arr[0];
        int current_max = arr[0];
        for (size_t i = 1; i < arr.size(); ++i) {
            current_max = std::max(arr[i], current_max + arr[i]);
            max_sum = std::max(max_sum, current_max);
        }

        // Kadane's algorithm to find the minimum subarray sum
        int min_sum = arr[0];
        int current_min = arr[0];
        for (size_t i = 1; i < arr.size(); ++i) {
            current_min = std::min(arr[i], current_min + arr[i]);
            min_sum = std::min(min_sum, current_min);
        }

        // The maximum absolute difference is the maximum of the absolute value of the max_sum and min_sum
        return std::max(std::abs(max_sum), std::abs(min_sum));
    }
};