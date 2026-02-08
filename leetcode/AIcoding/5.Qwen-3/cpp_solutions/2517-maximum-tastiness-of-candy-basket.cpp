#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxTastiness(vector<int>& price, int k) {
        sort(price.begin(), price.end());
        int n = price.size();
        vector<vector<int>> dp(k, vector<int>(n, 0));

        for (int i = 0; i < n; ++i) {
            dp[0][i] = price[i];
        }

        for (int i = 1; i < k; ++i) {
            for (int j = i; j < n; ++j) {
                dp[i][j] = max(dp[i][j - 1], dp[i - 1][j - 1]);
            }
        }

        return dp[k - 1][n - 1];
    }
};