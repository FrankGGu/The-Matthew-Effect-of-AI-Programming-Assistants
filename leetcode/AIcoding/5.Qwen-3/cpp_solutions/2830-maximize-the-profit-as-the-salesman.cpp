#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxProfit(int n, vector<int>& offers, vector<int>& price) {
        vector<vector<int>> dp(n, vector<int>(2, 0));
        vector<int> next(n, 0);

        for (int i = n - 1; i >= 0; --i) {
            dp[i][0] = max(dp[i + 1][0], dp[i + 1][1]);
            dp[i][1] = price[i];
            for (int j = 0; j < offers.size(); ++j) {
                if (offers[j][0] == i) {
                    int k = offers[j][1];
                    if (k < n)
                        dp[i][1] = max(dp[i][1], price[i] + next[k]);
                }
            }
            next[i] = max(dp[i][0], dp[i][1]);
        }

        return max(dp[0][0], dp[0][1]);
    }
};