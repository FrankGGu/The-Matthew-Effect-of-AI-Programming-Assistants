class Solution {
public:
    bool hasValidPath(vector<vector<char>>& grid) {
        int m = grid.size();
        if (m == 0) return false;
        int n = grid[0].size();
        if (n == 0) return false;

        vector<vector<vector<bool>>> dp(m, vector<vector<bool>>(n, vector<bool>(m + n + 1, false)));

        if (grid[0][0] == '(') {
            dp[0][0][1] = true;
        } else {
            return false;
        }

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (i == 0 && j == 0) continue;
                for (int k = 0; k <= m + n; ++k) {
                    if (i > 0) {
                        if (grid[i][j] == '(') {
                            if (k > 0 && dp[i-1][j][k-1]) {
                                dp[i][j][k] = true;
                            }
                        } else {
                            if (k < m + n && dp[i-1][j][k+1]) {
                                dp[i][j][k] = true;
                            }
                        }
                    }
                    if (j > 0) {
                        if (grid[i][j] == '(') {
                            if (k > 0 && dp[i][j-1][k-1]) {
                                dp[i][j][k] = true;
                            }
                        } else {
                            if (k < m + n && dp[i][j-1][k+1]) {
                                dp[i][j][k] = true;
                            }
                        }
                    }
                }
            }
        }

        return dp[m-1][n-1][0];
    }
};