#include <vector>
#include <algorithm>

class Solution {
public:
    int rob(std::vector<int>& nums) {
        if (nums.empty()) {
            return 0;
        }

        int n = nums.size();
        if (n == 1) {
            return nums[0];
        }

        int prev2 = 0; // Represents dp[i-2]
        int prev1 = 0; // Represents dp[i-1]

        for (int i = 0; i < n; ++i) {
            int current = std::max(prev1, nums[i] + prev2);
            prev2 = prev1;
            prev1 = current;
        }

        return prev1;
    }
};