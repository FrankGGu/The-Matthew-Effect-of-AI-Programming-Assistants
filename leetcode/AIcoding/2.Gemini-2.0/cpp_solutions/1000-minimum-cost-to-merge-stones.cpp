#include <vector>
#include <climits>

using namespace std;

class Solution {
public:
    int mergeStones(vector<int>& stones, int k) {
        int n = stones.size();
        if ((n - 1) % (k - 1) != 0) {
            return -1;
        }

        vector<int> prefixSum(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefixSum[i + 1] = prefixSum[i] + stones[i];
        }

        vector<vector<vector<int>>> dp(n, vector<vector<int>>(n, vector<int>(k + 1, INT_MAX)));

        for (int i = 0; i < n; ++i) {
            dp[i][i][1] = 0;
        }

        for (int len = 2; len <= n; ++len) {
            for (int i = 0; i <= n - len; ++i) {
                int j = i + len - 1;
                for (int m = 2; m <= k; ++m) {
                    for (int p = i; p < j; p += (k - 1)) {
                        if (dp[i][p][1] != INT_MAX && dp[p + 1][j][m - 1] != INT_MAX)
                            dp[i][j][m] = min(dp[i][j][m], dp[i][p][1] + dp[p + 1][j][m - 1]);
                    }
                }
                if (dp[i][j][k] != INT_MAX)
                    dp[i][j][1] = dp[i][j][k] + prefixSum[j + 1] - prefixSum[i];
            }
        }

        return dp[0][n - 1][1];
    }
};