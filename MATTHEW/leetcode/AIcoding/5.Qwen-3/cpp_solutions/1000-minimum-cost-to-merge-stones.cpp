#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minCostToMergeStones(string stones, int k) {
        int n = stones.size();
        vector<int> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + (stones[i] - '0');
        }

        vector<vector<int>> dp(n, vector<int>(n, 0));
        vector<vector<int>> cost(n, vector<int>(n, 0));

        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                cost[i][j] = cost[i][j - 1] + (stones[j] - '0');
            }
        }

        for (int length = 2; length <= n; ++length) {
            for (int i = 0; i <= n - length; ++i) {
                int j = i + length - 1;
                dp[i][j] = INT_MAX;
                for (int m = i; m < j; m += k - 1) {
                    if (m + 1 <= j) {
                        dp[i][j] = min(dp[i][j], dp[i][m] + dp[m + 1][j]);
                    }
                }
                if ((j - i) % (k - 1) == 0) {
                    dp[i][j] = min(dp[i][j], dp[i][j - 1] + cost[i][j]);
                }
            }
        }

        return dp[0][n - 1];
    }
};