class Solution {
public:
    int profitableSchemes(int n, int minProfit, vector<int>& group, vector<int>& profit) {
        const int MOD = 1e9 + 7;
        vector<vector<int>> dp(n + 1, vector<int>(minProfit + 1, 0));
        dp[0][0] = 1;

        for (int k = 0; k < group.size(); ++k) {
            int g = group[k];
            int p = profit[k];
            for (int i = n; i >= g; --i) {
                for (int j = minProfit; j >= 0; --j) {
                    int newProfit = min(j + p, minProfit);
                    dp[i][newProfit] = (dp[i][newProfit] + dp[i - g][j]) % MOD;
                }
            }
        }

        int result = 0;
        for (int i = 0; i <= n; ++i) {
            result = (result + dp[i][minProfit]) % MOD;
        }
        return result;
    }
};