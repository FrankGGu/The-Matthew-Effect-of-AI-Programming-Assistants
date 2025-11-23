#include <iostream>
#include <vector>
#include <algorithm>
#include <climits>

using namespace std;

class Solution {
public:
    long long minTotalSpaceWasted(vector<int>& nums, int k) {
        int n = nums.size();
        vector<long long> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + nums[i];
        }

        vector<vector<long long>> dp(k + 1, vector<long long>(n, LLONG_MAX));
        for (int i = 0; i < n; ++i) {
            dp[0][i] = prefix[n] - prefix[i];
        }

        for (int ops = 1; ops <= k; ++ops) {
            for (int i = 0; i < n; ++i) {
                for (int j = i; j < n; ++j) {
                    long long current = prefix[j + 1] - prefix[i];
                    long long avg = current / (j - i + 1);
                    long long waste = current - avg * (j - i + 1);
                    if (dp[ops - 1][j] != LLONG_MAX) {
                        dp[ops][i] = min(dp[ops][i], waste + dp[ops - 1][j]);
                    }
                }
            }
        }

        return dp[k][0];
    }
};