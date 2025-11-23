class Solution {
public:
    int longestVDiagonal(vector<vector<int>>& mat) {
        int m = mat.size(), n = mat[0].size();
        int maxLength = 0;

        vector<vector<int>> dp(m, vector<int>(n, 0));

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (i > 0 && j > 0 && mat[i][j] == mat[i-1][j-1]) {
                    dp[i][j] = dp[i-1][j-1] + 1;
                } else {
                    dp[i][j] = 1;
                }
                maxLength = max(maxLength, dp[i][j]);
            }
        }

        return maxLength;
    }
};