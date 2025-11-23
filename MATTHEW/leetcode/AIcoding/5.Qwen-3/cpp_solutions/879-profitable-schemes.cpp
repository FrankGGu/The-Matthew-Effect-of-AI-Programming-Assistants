#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int profitableSchemes(vector<int>& group, vector<int>& profit) {
        int n = group.size();
        int totalProfit = 0;
        for (int p : profit) {
            totalProfit += p;
        }
        vector<vector<int>> dp(n + 1, vector<int>(totalProfit + 1, 0));
        for (int i = 0; i <= n; ++i) {
            dp[i][0] = 1;
        }
        for (int i = 1; i <= n; ++i) {
            int g = group[i - 1];
            int p = profit[i - 1];
            for (int j = n; j >= i; --j) {
                for (int k = totalProfit; k >= 0; --k) {
                    dp[j][k] = (dp[j][k] + dp[j - 1][max(k - p, 0)]) % 1000000007;
                }
            }
        }
        return dp[n][totalProfit];
    }
};