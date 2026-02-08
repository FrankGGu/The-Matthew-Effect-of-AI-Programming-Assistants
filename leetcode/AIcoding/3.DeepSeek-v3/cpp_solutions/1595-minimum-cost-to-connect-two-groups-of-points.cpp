class Solution {
public:
    int connectTwoGroups(vector<vector<int>>& cost) {
        int size1 = cost.size();
        int size2 = cost[0].size();
        int mask = 1 << size2;
        vector<vector<int>> dp(size1 + 1, vector<int>(mask, INT_MAX / 2));
        dp[0][0] = 0;

        for (int i = 1; i <= size1; ++i) {
            for (int s = 0; s < mask; ++s) {
                for (int k = 0; k < size2; ++k) {
                    if ((s & (1 << k)) == 0) continue;
                    dp[i][s] = min(dp[i][s], dp[i][s ^ (1 << k)] + cost[i - 1][k]);
                    dp[i][s] = min(dp[i][s], dp[i - 1][s] + cost[i - 1][k]);
                    dp[i][s] = min(dp[i][s], dp[i - 1][s ^ (1 << k)] + cost[i - 1][k]);
                }
            }
        }

        return dp[size1][mask - 1];
    }
};