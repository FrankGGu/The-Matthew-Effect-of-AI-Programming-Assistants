class Solution {
public:
    int countPyramids(vector<vector<int>>& land) {
        int m = land.size(), n = land[0].size();
        vector<vector<int>> dp(m, vector<int>(n, 0));
        int count = 0;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (land[i][j] > 0) {
                    dp[i][j] = (i == 0 || j == 0 || j == n - 1) ? 1 : min({dp[i - 1][j - 1], dp[i - 1][j], dp[i - 1][j + 1]}) + 1;
                    count += dp[i][j];
                }
            }
        }
        return count;
    }
};