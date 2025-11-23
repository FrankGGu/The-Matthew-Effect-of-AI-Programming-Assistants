#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maxSum(vector<int>& nums, int k, int m) {
        int n = nums.size();
        vector<long long> prefixSum(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefixSum[i + 1] = prefixSum[i] + nums[i];
        }

        vector<vector<long long>> dp(k + 1, vector<long long>(n + 1, -1e18));
        dp[0][0] = 0;

        for (int i = 1; i <= k; ++i) {
            for (int j = 1; j <= n; ++j) {
                dp[i][j] = dp[i][j - 1];
                if (j >= m) {
                    for (int l = m; l <= j; ++l) {
                        dp[i][j] = max(dp[i][j], dp[i - 1][j - l] + (prefixSum[j] - prefixSum[j - l]));
                    }
                }
            }
        }

        return dp[k][n];
    }
};