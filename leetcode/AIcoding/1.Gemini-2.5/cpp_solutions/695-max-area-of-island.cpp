#include <vector>
#include <algorithm>

class Solution {
public:
    int maxAreaOfIsland(std::vector<std::vector<int>>& grid) {
        if (grid.empty() || grid[0].empty()) {
            return 0;
        }

        int max_area = 0;
        int rows = grid.size();
        int cols = grid[0].size();

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                if (grid[i][j] == 1) {
                    int current_area = dfs(grid, i, j);
                    max_area = std::max(max_area, current_area);
                }
            }
        }
        return max_area;
    }

private:
    int dfs(std::vector<std::vector<int>>& grid, int r, int c) {
        int rows = grid.size();
        int cols = grid[0].size();

        if (r < 0 || r >= rows || c < 0 || c >= cols || grid[r][c] == 0) {
            return 0;
        }

        grid[r][c] = 0;

        return 1 + dfs(grid, r + 1, c) + dfs(grid, r - 1, c) + dfs(grid, r, c + 1) + dfs(grid, r, c - 1);
    }
};