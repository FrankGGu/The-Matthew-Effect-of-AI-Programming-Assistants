#include <iostream>
#include <vector>
#include <climits>

using namespace std;

class Solution {
public:
    int maxSumAfterKDisjointSubarrays(vector<int>& nums, int k) {
        int n = nums.size();
        vector<vector<int>> dp(k + 1, vector<int>(n, INT_MIN));
        vector<vector<int>> pre(k + 1, vector<int>(n, INT_MIN));

        for (int i = 0; i < n; ++i) {
            dp[0][i] = 0;
            pre[0][i] = 0;
        }

        for (int i = 0; i < n; ++i) {
            for (int j = 1; j <= k; ++j) {
                if (i == 0) {
                    dp[j][i] = nums[i];
                    pre[j][i] = nums[i];
                } else {
                    dp[j][i] = max(dp[j][i - 1], pre[j - 1][i - 1] + nums[i]);
                    pre[j][i] = max(pre[j][i - 1], dp[j][i]);
                }
            }
        }

        return dp[k][n - 1];
    }
};