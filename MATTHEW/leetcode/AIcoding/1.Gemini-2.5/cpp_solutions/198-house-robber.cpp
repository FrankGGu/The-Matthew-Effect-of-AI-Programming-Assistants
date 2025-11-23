#include <vector>
#include <algorithm>

class Solution {
public:
    int rob(std::vector<int>& nums) {
        int n = nums.size();

        if (n == 0) {
            return 0;
        }
        if (n == 1) {
            return nums[0];
        }

        int rob_prev2 = nums[0];
        int rob_prev1 = std::max(nums[0], nums[1]);

        for (int i = 2; i < n; ++i) {
            int rob_current = std::max(nums[i] + rob_prev2, rob_prev1);
            rob_prev2 = rob_prev1;
            rob_prev1 = rob_current;
        }

        return rob_prev1;
    }
};