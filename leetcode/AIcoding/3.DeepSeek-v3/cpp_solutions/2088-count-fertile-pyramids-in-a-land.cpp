class Solution {
public:
    int countPyramids(vector<vector<int>>& grid) {
        int m = grid.size();
        if (m == 0) return 0;
        int n = grid[0].size();
        vector<vector<int>> dp_up(m, vector<int>(n, 0));
        vector<vector<int>> dp_down(m, vector<int>(n, 0));

        for (int i = m - 1; i >= 0; --i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 0) {
                    dp_up[i][j] = 0;
                } else {
                    if (i == m - 1 || j == 0 || j == n - 1) {
                        dp_up[i][j] = 1;
                    } else {
                        dp_up[i][j] = 1 + min({dp_up[i + 1][j - 1], dp_up[i + 1][j], dp_up[i + 1][j + 1]});
                    }
                }
            }
        }

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 0) {
                    dp_down[i][j] = 0;
                } else {
                    if (i == 0 || j == 0 || j == n - 1) {
                        dp_down[i][j] = 1;
                    } else {
                        dp_down[i][j] = 1 + min({dp_down[i - 1][j - 1], dp_down[i - 1][j], dp_down[i - 1][j + 1]});
                    }
                }
            }
        }

        int res = 0;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (dp_up[i][j] > 1) {
                    res += dp_up[i][j] - 1;
                }
                if (dp_down[i][j] > 1) {
                    res += dp_down[i][j] - 1;
                }
            }
        }

        return res;
    }
};