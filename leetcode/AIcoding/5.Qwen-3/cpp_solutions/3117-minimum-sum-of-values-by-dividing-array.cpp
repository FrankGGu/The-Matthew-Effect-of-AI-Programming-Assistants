#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minSumOfValues(vector<int>& nums, int k) {
        int n = nums.size();
        vector<vector<int>> dp(k + 1, vector<int>(n, 0));

        for (int i = 0; i < n; ++i) {
            dp[0][i] = nums[i];
        }

        for (int i = 1; i <= k; ++i) {
            for (int j = i; j < n; ++j) {
                dp[i][j] = INT_MAX;
                for (int m = i - 1; m < j; ++m) {
                    dp[i][j] = min(dp[i][j], dp[i - 1][m] + nums[j]);
                }
            }
        }

        return dp[k][n - 1];
    }
};