#include <vector>

using namespace std;

class Solution {
public:
    int solve(int i, int j, vector<vector<int>>& grid, vector<vector<int>>& dp) {
        if (i >= grid.size() || j >= grid[0].size()) {
            return 0;
        }
        if (dp[i][j] != -1) {
            return dp[i][j];
        }
        int ans = 0;
        if (i + 1 < grid.size()) {
            ans = max(ans, solve(i + 1, j, grid, dp));
        }
        if (j + 1 < grid[0].size()) {
            ans = max(ans, solve(i, j + 1, grid, dp));
        }
        return dp[i][j] = ans + grid[i][j];
    }

    int solve(int i, int j, vector<vector<int>>& grid) {
        if (i >= grid.size() || j >= grid[0].size()) {
            return 0;
        }

        int ans = 0;
        if (i + 1 < grid.size()) {
            ans = max(ans, solve(i + 1, j, grid));
        }
        if (j + 1 < grid[0].size()) {
            ans = max(ans, solve(i, j + 1, grid));
        }
        return ans + grid[i][j];
    }

    int solve2(int i, int j, int n, int m, vector<vector<int>>& grid, vector<vector<int>>& dp) {
        if (i == n - 1 && j == m - 1) {
            return grid[i][j];
        }
        if (i >= n || j >= m) {
            return -1e9;
        }
        if (dp[i][j] != -1) {
            return dp[i][j];
        }
        int right = solve2(i, j + 1, n, m, grid, dp);
        int down = solve2(i + 1, j, n, m, grid, dp);
        return dp[i][j] = max(right, down) + grid[i][j];
    }

    int solve3(int i, int j, int n, int m, vector<vector<int>>& grid) {
        if (i == n - 1 && j == m - 1) {
            return grid[i][j];
        }
        if (i >= n || j >= m) {
            return -1e9;
        }
        int right = solve3(i, j + 1, n, m, grid);
        int down = solve3(i + 1, j, n, m, grid);
        return max(right, down) + grid[i][j];
    }

    int solve4(vector<vector<int>>& grid) {
        int n = grid.size();
        int m = grid[0].size();
        vector<vector<int>> dp(n, vector<int>(m, 0));
        dp[n - 1][m - 1] = grid[n - 1][m - 1];

        for (int i = n - 1; i >= 0; i--) {
            for (int j = m - 1; j >= 0; j--) {
                if (i == n - 1 && j == m - 1) {
                    continue;
                }
                int right = (j + 1 < m) ? dp[i][j + 1] : -1e9;
                int down = (i + 1 < n) ? dp[i + 1][j] : -1e9;
                dp[i][j] = max(right, down) + grid[i][j];
            }
        }

        return dp[0][0];
    }

    int solve5(vector<vector<int>>& grid) {
        int n = grid.size();
        int m = grid[0].size();
        vector<int> dp(m, 0);
        dp[m - 1] = grid[n - 1][m - 1];

        for (int i = n - 1; i >= 0; i--) {
            vector<int> newDp(m, 0);
            for (int j = m - 1; j >= 0; j--) {
                if (i == n - 1 && j == m - 1) {
                    newDp[j] = grid[i][j];
                    continue;
                }
                int right = (j + 1 < m) ? newDp[j + 1] : -1e9;
                int down = (i + 1 < n) ? dp[j] : -1e9;
                newDp[j] = max(right, down) + grid[i][j];
            }
            dp = newDp;
        }

        return dp[0];
    }

    int solve6(vector<vector<int>>& grid) {
        int n = grid.size();
        int m = grid[0].size();

        vector<int> dp(m, 0);
        for (int i = n - 1; i >= 0; --i) {
            for (int j = m - 1; j >= 0; --j) {
                if (i == n - 1 && j == m - 1) {
                    dp[j] = grid[i][j];
                } else {
                    int down = (i + 1 < n) ? dp[j] : -1e9;
                    int right = (j + 1 < m) ? dp[j + 1] : -1e9;
                    dp[j] = grid[i][j] + max(down, right);
                }
            }
        }
        return dp[0];
    }

    int marbleGame(vector<vector<int>>& grid) {
        return solve6(grid);
    }
};