class Solution {
public:
    bool isPossibleToCutPath(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();

        function<bool(int, int)> dfs = [&](int i, int j) {
            if (i == m - 1 && j == n - 1) return true;
            if (i >= m || j >= n || grid[i][j] == 0) return false;
            grid[i][j] = 0;
            return dfs(i + 1, j) || dfs(i, j + 1);
        };

        if (!dfs(0, 0)) return true;
        grid[0][0] = 1;
        return !dfs(0, 0);
    }
};