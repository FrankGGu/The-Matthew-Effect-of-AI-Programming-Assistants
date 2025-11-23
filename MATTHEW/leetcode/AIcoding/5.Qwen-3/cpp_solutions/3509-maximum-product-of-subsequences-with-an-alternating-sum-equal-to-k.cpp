#include <iostream>
#include <vector>
#include <unordered_map>
#include <climits>

using namespace std;

class Solution {
public:
    int maxProductSubsequence(vector<int>& nums, int k) {
        int n = nums.size();
        vector<vector<long long>> dp(n + 1, vector<long long>(k + 1, -1));
        dp[0][0] = 1;

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j <= k; ++j) {
                if (dp[i][j] == -1) continue;
                dp[i + 1][j] = max(dp[i + 1][j], dp[i][j]);
                if (j + nums[i] <= k) {
                    dp[i + 1][j + nums[i]] = max(dp[i + 1][j + nums[i]], dp[i][j] * nums[i]);
                }
            }
        }

        return dp[n][k];
    }
};