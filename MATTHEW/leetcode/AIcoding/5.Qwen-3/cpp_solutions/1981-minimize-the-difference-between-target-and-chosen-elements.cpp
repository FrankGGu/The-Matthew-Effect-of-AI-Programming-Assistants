#include <iostream>
#include <vector>
#include <algorithm>
#include <climits>

using namespace std;

class Solution {
public:
    int minimizeDifference(vector<int>& nums, int target) {
        int n = nums.size();
        vector<vector<int>> dp(n + 1, vector<int>(target + 1, INT_MAX));
        dp[0][0] = 0;

        for (int i = 1; i <= n; ++i) {
            for (int j = 0; j <= target; ++j) {
                if (dp[i - 1][j] != INT_MAX) {
                    dp[i][j] = min(dp[i][j], dp[i - 1][j]);
                    if (j + nums[i - 1] <= target) {
                        dp[i][j + nums[i - 1]] = min(dp[i][j + nums[i - 1]], dp[i - 1][j] + nums[i - 1]);
                    }
                }
            }
        }

        int result = INT_MAX;
        for (int j = 0; j <= target; ++j) {
            if (dp[n][j] != INT_MAX) {
                result = min(result, abs(target - j));
            }
        }

        return result;
    }
};