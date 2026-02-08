class Solution {
public:
    int profitableSchemes(int G, int P, vector<int>& profit, vector<int>& group) {
        const int MOD = 1e9 + 7;
        int n = profit.size();
        vector<vector<int>> dp(G + 1, vector<int>(P + 1, 0));
        dp[0][0] = 1;

        for (int i = 0; i < n; ++i) {
            int g = group[i], p = profit[i];
            for (int j = G; j >= g; --j) {
                for (int k = P; k >= 0; --k) {
                    dp[j][min(k + p, P)] = (dp[j][min(k + p, P)] + dp[j - g][k]) % MOD;
                }
            }
        }

        int result = 0;
        for (int j = 0; j <= G; ++j) {
            result = (result + dp[j][P]) % MOD;
        }
        return result;
    }
};