#include <vector>
#include <algorithm>

class Solution {
public:
    int rob(std::vector<int>& nums) {
        if (nums.empty()) {
            return 0;
        }
        if (nums.size() == 1) {
            return nums[0];
        }

        int prev2_max_sum = 0;
        int prev1_max_sum = 0;

        for (int num : nums) {
            int current_max_sum = std::max(prev1_max_sum, num + prev2_max_sum);

            prev2_max_sum = prev1_max_sum;
            prev1_max_sum = current_max_sum;
        }

        return prev1_max_sum;
    }
};