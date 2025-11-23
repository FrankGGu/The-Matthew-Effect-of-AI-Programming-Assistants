#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    bool validPartition(vector<int>& nums) {
        int n = nums.size();
        vector<bool> dp(n + 1, false);
        dp[0] = true;

        for (int i = 3; i <= n; ++i) {
            if (dp[i - 3] && nums[i - 1] == nums[i - 2] && nums[i - 2] == nums[i - 3]) {
                dp[i] = true;
            } else if (dp[i - 2] && nums[i - 1] == nums[i - 2]) {
                dp[i] = true;
            } else if (dp[i - 1] && nums[i - 1] == nums[i - 2] + 1 && nums[i - 2] == nums[i - 3] + 1) {
                dp[i] = true;
            }
        }

        return dp[n];
    }
};