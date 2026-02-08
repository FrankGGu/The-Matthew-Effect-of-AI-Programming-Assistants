#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int mctFromLeafTree(vector<int>& leafValues) {
        int n = leafValues.size();
        vector<vector<int>> dp(n, vector<int>(n, 0));

        for (int length = 2; length <= n; ++length) {
            for (int i = 0; i + length - 1 < n; ++i) {
                int j = i + length - 1;
                dp[i][j] = INT_MAX;
                for (int k = i; k < j; ++k) {
                    int cost = dp[i][k] + dp[k+1][j] + max(leafValues[i], leafValues[k]) * max(leafValues[k+1], leafValues[j]);
                    dp[i][j] = min(dp[i][j], cost);
                }
            }
        }

        return dp[0][n-1];
    }
};