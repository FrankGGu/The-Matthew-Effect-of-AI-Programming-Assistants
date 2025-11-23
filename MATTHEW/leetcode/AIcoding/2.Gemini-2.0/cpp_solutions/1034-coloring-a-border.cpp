#include <vector>

using namespace std;

class Solution {
public:
    vector<vector<int>> colorBorder(vector<vector<int>>& grid, int row, int col, int color) {
        int m = grid.size();
        int n = grid[0].size();
        int originalColor = grid[row][col];
        vector<vector<bool>> visited(m, vector<bool>(n, false));
        vector<pair<int, int>> borderCells;

        function<void(int, int)> dfs = [&](int i, int j) {
            if (i < 0 || i >= m || j < 0 || j >= n || visited[i][j] || grid[i][j] != originalColor) {
                return;
            }

            visited[i][j] = true;

            bool isBorder = false;
            if (i == 0 || i == m - 1 || j == 0 || j == n - 1) {
                isBorder = true;
            } else if (grid[i - 1][j] != originalColor || grid[i + 1][j] != originalColor ||
                       grid[i][j - 1] != originalColor || grid[i][j + 1] != originalColor) {
                isBorder = true;
            }

            if (isBorder) {
                borderCells.push_back({i, j});
            }

            dfs(i + 1, j);
            dfs(i - 1, j);
            dfs(i, j + 1);
            dfs(i, j - 1);
        };

        dfs(row, col);

        for (auto& cell : borderCells) {
            grid[cell.first][cell.second] = color;
        }

        return grid;
    }
};