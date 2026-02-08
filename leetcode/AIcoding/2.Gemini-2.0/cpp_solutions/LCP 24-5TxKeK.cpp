#include <vector>

using namespace std;

class Solution {
public:
    int stoneGameVII(vector<int>& stones) {
        int n = stones.size();
        vector<vector<int>> dp(n, vector<int>(n, 0));
        vector<int> prefixSum(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefixSum[i + 1] = prefixSum[i] + stones[i];
        }

        for (int len = 2; len <= n; ++len) {
            for (int i = 0; i <= n - len; ++i) {
                int j = i + len - 1;
                dp[i][j] = max(prefixSum[j + 1] - prefixSum[i + 1] - dp[i + 1][j],
                                prefixSum[j] - prefixSum[i] - dp[i][j - 1]);
            }
        }

        return dp[0][n - 1];
    }
};