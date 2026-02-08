class Solution {
public:
    int cherryPickup(vector<vector<int>>& grid) {
        int n = grid.size();
        vector<vector<vector<int>>> dp(n, vector<vector<int>>(n, vector<int>(n, -1)));
        return max(0, helper(grid, dp, 0, 0, 0));
    }

    int helper(vector<vector<int>>& grid, vector<vector<vector<int>>>& dp, int r1, int c1, int r2) {
        int c2 = r1 + c1 - r2;
        if (r1 >= grid.size() || c1 >= grid.size() || r2 >= grid.size() || c2 >= grid.size() || 
            grid[r1][c1] == -1 || grid[r2][c2] == -1) {
            return INT_MIN;
        }
        if (dp[r1][c1][r2] != -1) {
            return dp[r1][c1][r2];
        }
        if (r1 == grid.size() - 1 && c1 == grid.size() - 1) {
            return grid[r1][c1];
        }
        int res = grid[r1][c1];
        if (r1 != r2 || c1 != c2) {
            res += grid[r2][c2];
        }
        int temp = max(helper(grid, dp, r1 + 1, c1, r2 + 1), helper(grid, dp, r1 + 1, c1, r2));
        temp = max(temp, helper(grid, dp, r1, c1 + 1, r2 + 1));
        temp = max(temp, helper(grid, dp, r1, c1 + 1, r2));
        res += temp;
        dp[r1][c1][r2] = res;
        return res;
    }
};