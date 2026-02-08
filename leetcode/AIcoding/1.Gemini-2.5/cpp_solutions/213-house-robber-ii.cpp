#include <vector>
#include <algorithm> // For std::max

class Solution {
public:
    int rob_linear_range(const std::vector<int>& nums, int start, int end) {
        if (start > end) {
            return 0;
        }

        int dp_i_minus_2 = 0; // Represents max money up to house i-2
        int dp_i_minus_1 = 0; // Represents max money up to house i-1

        for (int i = start; i <= end; ++i) {
            int current_max = std::max(dp_i_minus_1, dp_i_minus_2 + nums[i]);
            dp_i_minus_2 = dp_i_minus_1;
            dp_i_minus_1 = current_max;
        }
        return dp_i_minus_1;
    }

    int rob(std::vector<int>& nums) {
        int n = nums.size();

        if (n == 0) {
            return 0;
        }
        if (n == 1) {
            return nums[0];
        }

        // Case 1: Rob houses from index 0 to n-2 (excluding the last house)
        int result1 = rob_linear_range(nums, 0, n - 2);

        // Case 2: Rob houses from index 1 to n-1 (excluding the first house)
        int result2 = rob_linear_range(nums, 1, n - 1);

        // The maximum amount of money is the maximum of these two cases
        return std::max(result1, result2);
    }
};