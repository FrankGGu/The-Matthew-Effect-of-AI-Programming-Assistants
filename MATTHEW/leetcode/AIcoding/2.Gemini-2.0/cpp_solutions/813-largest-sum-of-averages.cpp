#include <vector>

using namespace std;

class Solution {
public:
    double largestSumOfAverages(vector<int>& nums, int k) {
        int n = nums.size();
        vector<double> prefixSum(n + 1, 0.0);
        for (int i = 1; i <= n; ++i) {
            prefixSum[i] = prefixSum[i - 1] + nums[i - 1];
        }

        vector<vector<double>> dp(n + 1, vector<double>(k + 1, 0.0));

        for (int i = 1; i <= n; ++i) {
            dp[i][1] = prefixSum[i] / i;
        }

        for (int j = 2; j <= k; ++j) {
            for (int i = j; i <= n; ++i) {
                for (int x = j - 1; x < i; ++x) {
                    dp[i][j] = max(dp[i][j], dp[x][j - 1] + (prefixSum[i] - prefixSum[x]) / (i - x));
                }
            }
        }

        return dp[n][k];
    }
};