class Solution {
public:
    vector<vector<int>> colorBorder(vector<vector<int>>& grid, int row, int col, int color) {
        int m = grid.size();
        int n = grid[0].size();
        vector<vector<bool>> visited(m, vector<bool>(n, false));
        vector<pair<int, int>> borders;
        int originalColor = grid[row][col];
        dfs(grid, row, col, originalColor, visited, borders);
        for (auto& p : borders) {
            grid[p.first][p.second] = color;
        }
        return grid;
    }

private:
    void dfs(vector<vector<int>>& grid, int x, int y, int originalColor, vector<vector<bool>>& visited, vector<pair<int, int>>& borders) {
        int m = grid.size();
        int n = grid[0].size();
        visited[x][y] = true;
        bool isBorder = false;
        int dirs[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
        for (auto& dir : dirs) {
            int nx = x + dir[0];
            int ny = y + dir[1];
            if (nx < 0 || nx >= m || ny < 0 || ny >= n || grid[nx][ny] != originalColor) {
                isBorder = true;
            } else if (!visited[nx][ny]) {
                dfs(grid, nx, ny, originalColor, visited, borders);
            }
        }
        if (isBorder) {
            borders.emplace_back(x, y);
        }
    }
};