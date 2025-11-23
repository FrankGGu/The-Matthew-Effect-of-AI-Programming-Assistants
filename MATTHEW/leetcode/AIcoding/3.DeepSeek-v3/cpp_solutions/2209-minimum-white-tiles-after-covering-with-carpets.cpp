class Solution {
public:
    int minimumWhiteTiles(string floor, int numCarpets, int carpetLen) {
        int n = floor.size();
        vector<vector<int>> dp(numCarpets + 1, vector<int>(n + 1, 0));

        for (int i = 1; i <= n; ++i) {
            dp[0][i] = dp[0][i - 1] + (floor[i - 1] == '1' ? 1 : 0);
        }

        for (int k = 1; k <= numCarpets; ++k) {
            for (int i = 1; i <= n; ++i) {
                if (i <= carpetLen) {
                    dp[k][i] = 0;
                } else {
                    dp[k][i] = min(dp[k][i - 1] + (floor[i - 1] == '1' ? 1 : 0), dp[k - 1][i - carpetLen]);
                }
            }
        }

        return dp[numCarpets][n];
    }
};