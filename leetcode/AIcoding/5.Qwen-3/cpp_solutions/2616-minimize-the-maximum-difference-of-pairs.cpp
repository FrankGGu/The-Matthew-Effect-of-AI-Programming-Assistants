#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimizeMax(vector<int>& nums, int p) {
        sort(nums.begin(), nums.end());
        int n = nums.size();
        vector<int> dp(n, 0);

        for (int i = 1; i < n; ++i) {
            dp[i] = dp[i - 1];
            if (i >= 1) {
                dp[i] = min(dp[i], dp[i - 2] + nums[i] - nums[i - 1]);
            }
        }

        return dp[n - 1];
    }
};