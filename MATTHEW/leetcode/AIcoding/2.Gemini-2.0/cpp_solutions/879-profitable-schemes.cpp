#include <vector>

using namespace std;

class Solution {
public:
    int profitableSchemes(int n, int minProfit, vector<int>& group, vector<int>& profit) {
        int len = group.size();
        int mod = 1e9 + 7;
        vector<vector<vector<int>>> dp(len + 1, vector<vector<int>>(n + 1, vector<int>(minProfit + 1, 0)));
        dp[0][0][0] = 1;

        for (int i = 1; i <= len; ++i) {
            int g = group[i - 1];
            int p = profit[i - 1];
            for (int j = 0; j <= n; ++j) {
                for (int k = 0; k <= minProfit; ++k) {
                    dp[i][j][k] = dp[i - 1][j][k];
                    if (j >= g) {
                        dp[i][j][k] = (dp[i][j][k] + dp[i - 1][j - g][max(0, k - p)]) % mod;
                    }
                }
            }
        }

        int ans = 0;
        for (int j = 0; j <= n; ++j) {
            ans = (ans + dp[len][j][minProfit]) % mod;
        }

        return ans;
    }
};