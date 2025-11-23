class Solution {
public:
    vector<vector<int>> colorBorder(vector<vector<int>>& grid, int row, int col, int color) {
        int m = grid.size(), n = grid[0].size();
        int originalColor = grid[row][col];
        vector<vector<int>> result = grid;
        vector<vector<bool>> visited(m, vector<bool>(n, false));
        vector<pair<int, int>> borderCells;

        vector<pair<int, int>> directions = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};

        function<bool(int, int)> isBorder = [&](int r, int c) {
            for (auto& dir : directions) {
                int newR = r + dir.first, newC = c + dir.second;
                if (newR < 0 || newR >= m || newC < 0 || newC >= n || grid[newR][newC] != originalColor) {
                    return true;
                }
            }
            return false;
        };

        function<void(int, int)> dfs = [&](int r, int c) {
            visited[r][c] = true;
            if (isBorder(r, c)) {
                borderCells.push_back({r, c});
            }
            for (auto& dir : directions) {
                int newR = r + dir.first, newC = c + dir.second;
                if (newR >= 0 && newR < m && newC >= 0 && newC < n && !visited[newR][newC] && grid[newR][newC] == originalColor) {
                    dfs(newR, newC);
                }
            }
        };

        dfs(row, col);

        for (auto& cell : borderCells) {
            result[cell.first][cell.second] = color;
        }

        return result;
    }
};