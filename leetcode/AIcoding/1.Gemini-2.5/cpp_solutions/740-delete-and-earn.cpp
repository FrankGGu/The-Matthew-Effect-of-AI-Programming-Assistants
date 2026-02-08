#include <vector>
#include <algorithm> // For std::max

class Solution {
public:
    long long deleteAndEarn(std::vector<int>& nums) {
        if (nums.empty()) {
            return 0;
        }

        int max_val = 0;
        for (int num : nums) {
            if (num > max_val) {
                max_val = num;
            }
        }

        std::vector<long long> earn(max_val + 1, 0);
        for (int num : nums) {
            earn[num] += num;
        }

        std::vector<long long> dp(max_val + 1, 0);

        dp[0] = 0; 
        if (max_val >= 1) {
            dp[1] = earn[1];
        }

        for (int i = 2; i <= max_val; ++i) {
            dp[i] = std::max(dp[i-1], dp[i-2] + earn[i]);
        }

        return dp[max_val];
    }
};