#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minOperations(vector<int>& nums) {
        int n = nums.size();
        vector<int> dp(n + 1, 1e9);
        dp[0] = 0;

        for (int i = 1; i <= n; ++i) {
            if (nums[i - 1] == 0) {
                dp[i] = dp[i - 1] + 1;
                if (i >= 2) {
                    dp[i] = min(dp[i], dp[i - 2] + 1);
                }
            } else {
                dp[i] = dp[i - 1];
            }
        }

        return dp[n];
    }
};