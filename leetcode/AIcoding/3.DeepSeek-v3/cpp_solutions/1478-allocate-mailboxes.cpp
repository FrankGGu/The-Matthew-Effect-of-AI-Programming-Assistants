class Solution {
public:
    int minDistance(vector<int>& houses, int k) {
        sort(houses.begin(), houses.end());
        int n = houses.size();
        vector<vector<int>> cost(n, vector<int>(n, 0));
        for (int i = 0; i < n; ++i) {
            for (int j = i; j < n; ++j) {
                int median = houses[(i + j) / 2];
                for (int l = i; l <= j; ++l) {
                    cost[i][j] += abs(houses[l] - median);
                }
            }
        }
        vector<vector<int>> dp(k + 1, vector<int>(n, INT_MAX / 2));
        for (int i = 0; i < n; ++i) {
            dp[1][i] = cost[0][i];
        }
        for (int m = 2; m <= k; ++m) {
            for (int j = 0; j < n; ++j) {
                for (int i = 0; i < j; ++i) {
                    dp[m][j] = min(dp[m][j], dp[m - 1][i] + cost[i + 1][j]);
                }
            }
        }
        return dp[k][n - 1];
    }
};