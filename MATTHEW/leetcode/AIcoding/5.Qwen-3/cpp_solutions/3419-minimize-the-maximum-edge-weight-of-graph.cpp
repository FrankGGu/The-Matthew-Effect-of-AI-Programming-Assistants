#include <iostream>
#include <vector>
#include <algorithm>
#include <climits>

using namespace std;

class Solution {
public:
    int minimizeMax(vector<int>& nums, int m) {
        sort(nums.begin(), nums.end());
        int n = nums.size();
        vector<vector<int>> dp(n + 1, vector<int>(m + 1, INT_MAX));
        dp[0][0] = 0;

        for (int i = 1; i <= n; ++i) {
            dp[i][0] = 0;
            for (int j = 1; j <= m; ++j) {
                int maxVal = 0;
                for (int k = i - 1; k >= 0 && k >= i - j; --k) {
                    maxVal = max(maxVal, nums[i - 1] - nums[k]);
                    dp[i][j] = min(dp[i][j], dp[k][j - 1] + maxVal);
                }
            }
        }

        return dp[n][m];
    }
};