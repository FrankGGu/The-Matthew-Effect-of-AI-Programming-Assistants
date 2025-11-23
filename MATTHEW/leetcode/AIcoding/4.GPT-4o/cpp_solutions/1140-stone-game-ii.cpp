class Solution {
public:
    int stoneGameII(vector<int>& piles) {
        int n = piles.size();
        vector<int> prefix(n + 1, 0);
        for (int i = n - 1; i >= 0; --i) {
            prefix[i] = prefix[i + 1] + piles[i];
        }

        vector<vector<int>> dp(n, vector<int>(n + 1, 0));

        for (int i = n - 1; i >= 0; --i) {
            for (int m = 1; m <= n; ++m) {
                for (int x = 1; x <= 2 * m && i + x - 1 < n; ++x) {
                    dp[i][m] = max(dp[i][m], prefix[i] - dp[i + x][max(m, x)]);
                }
            }
        }

        return dp[0][1];
    }
};