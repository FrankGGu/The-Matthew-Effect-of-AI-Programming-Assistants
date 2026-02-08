class Solution {
public:
    int ways(vector<string>& pizza, int k) {
        int m = pizza.size(), n = pizza[0].size();
        vector<vector<vector<int>>> dp(m + 1, vector<vector<int>>(n + 1, vector<int>(k + 1, 0)));
        vector<vector<int>> prefix(m + 1, vector<int>(n + 1, 0));

        for (int i = m - 1; i >= 0; i--) {
            for (int j = n - 1; j >= 0; j--) {
                prefix[i][j] = (pizza[i][j] == 'A') + prefix[i + 1][j] + prefix[i][j + 1] - prefix[i + 1][j + 1];
            }
        }

        for (int i = 0; i <= m; i++) {
            for (int j = 0; j <= n; j++) {
                dp[i][j][0] = prefix[i][j] > 0 ? 1 : 0;
            }
        }

        for (int cuts = 1; cuts <= k; cuts++) {
            for (int i = m - 1; i >= 0; i--) {
                for (int j = n - 1; j >= 0; j--) {
                    for (int x = i + 1; x <= m; x++) {
                        if (prefix[i][j] - prefix[x][j] > 0) {
                            dp[i][j][cuts] = (dp[i][j][cuts] + dp[x][j][cuts - 1]) % 1000000007;
                        }
                    }
                    for (int y = j + 1; y <= n; y++) {
                        if (prefix[i][j] - prefix[i][y] > 0) {
                            dp[i][j][cuts] = (dp[i][j][cuts] + dp[i][y][cuts - 1]) % 1000000007;
                        }
                    }
                }
            }
        }

        return dp[0][0][k];
    }
};