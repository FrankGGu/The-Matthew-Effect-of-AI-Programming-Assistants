#include <vector>

using namespace std;

class Solution {
public:
    bool validPartition(vector<int>& nums) {
        int n = nums.size();
        vector<bool> dp(n + 1, false);
        dp[0] = true;

        for (int i = 0; i < n; ++i) {
            if (dp[i]) {
                if (i + 1 < n && nums[i] == nums[i + 1]) {
                    dp[i + 2] = true;
                }
                if (i + 2 < n && nums[i] == nums[i + 1] && nums[i + 1] == nums[i + 2]) {
                    dp[i + 3] = true;
                }
                if (i + 2 < n && nums[i + 1] == nums[i] + 1 && nums[i + 2] == nums[i + 1] + 1) {
                    dp[i + 3] = true;
                }
            }
        }

        return dp[n];
    }
};