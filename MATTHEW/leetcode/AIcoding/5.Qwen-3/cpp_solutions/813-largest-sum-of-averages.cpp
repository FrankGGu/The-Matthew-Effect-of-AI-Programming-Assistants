#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    double largestSumOfAverages(vector<int>& nums, int k) {
        int n = nums.size();
        vector<double> dp(n + 1, 0.0);
        for (int i = 1; i <= n; ++i) {
            dp[i] = dp[i - 1] + nums[i - 1];
        }
        for (int t = 2; t <= k; ++t) {
            vector<double> new_dp(n + 1, 0.0);
            for (int i = t - 1; i < n; ++i) {
                for (int j = t - 2; j < i; ++j) {
                    new_dp[i] = max(new_dp[i], dp[j] + (dp[i] - dp[j]) / (i - j));
                }
            }
            dp = new_dp;
        }
        return dp[n];
    }
};