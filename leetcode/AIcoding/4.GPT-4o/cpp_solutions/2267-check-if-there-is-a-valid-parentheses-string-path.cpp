class Solution {
public:
    bool hasValidPath(vector<vector<char>>& grid) {
        int m = grid.size(), n = grid[0].size();
        vector<vector<int>> dp(m, vector<int>(n, -1));
        return dfs(grid, 0, 0, 0, dp);
    }

    bool dfs(vector<vector<char>>& grid, int i, int j, int balance, vector<vector<int>>& dp) {
        if (i < 0 || i >= grid.size() || j < 0 || j >= grid[0].size()) return false;
        if (grid[i][j] == ')') balance--;
        else balance++;
        if (balance < 0) return false;
        if (i == grid.size() - 1 && j == grid[0].size() - 1) return balance == 0;
        if (dp[i][j] != -1) return dp[i][j] == 1;

        bool result = dfs(grid, i + 1, j, balance, dp) || dfs(grid, i, j + 1, balance, dp);
        dp[i][j] = result ? 1 : 0;
        return result;
    }
};