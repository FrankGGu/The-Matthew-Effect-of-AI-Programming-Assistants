class Solution {
public:
    int countFertilePyramids(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();
        int ans = 0;

        vector<vector<int>> dp(m, vector<int>(n, 0));

        for (int i = m - 1; i >= 0; --i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 1) {
                    if (i + 1 < m && j - 1 >= 0 && j + 1 < n) {
                        dp[i][j] = min({dp[i + 1][j - 1], dp[i + 1][j], dp[i + 1][j + 1]}) + 1;
                    } else {
                        dp[i][j] = 1;
                    }
                    ans += dp[i][j] -1;
                }
            }
        }

        vector<vector<int>> dp_inv(m, vector<int>(n, 0));

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 1) {
                    if (i - 1 >= 0 && j - 1 >= 0 && j + 1 < n) {
                        dp_inv[i][j] = min({dp_inv[i - 1][j - 1], dp_inv[i - 1][j], dp_inv[i - 1][j + 1]}) + 1;
                    } else {
                        dp_inv[i][j] = 1;
                    }
                    ans += dp_inv[i][j] -1;
                }
            }
        }

        return ans;
    }
};