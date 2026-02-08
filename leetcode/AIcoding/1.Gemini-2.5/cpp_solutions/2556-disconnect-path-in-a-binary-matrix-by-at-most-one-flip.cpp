#include <vector>

class Solution {
public:
    bool findAndMarkPath(int r, int c, int m, int n, const std::vector<std::vector<int>>& grid, std::vector<std::vector<bool>>& path_cells) {
        if (r < 0 || r >= m || c < 0 || c >= n || grid[r][c] == 0 || path_cells[r][c]) {
            return false;
        }
        if (r == m - 1 && c == n - 1) {
            path_cells[r][c] = true;
            return true;
        }

        path_cells[r][c] = true;

        if (findAndMarkPath(r, c + 1, m, n, grid, path_cells)) {
            return true;
        }
        if (findAndMarkPath(r + 1, c, m, n, grid, path_cells)) {
            return true;
        }

        path_cells[r][c] = false;
        return false;
    }

    bool pathExistsRecursive(int r, int c, int m, int n, const std::vector<std::vector<int>>& grid,
                             const std::vector<std::vector<bool>>& blocked_cells,
                             std::vector<std::vector<bool>>& current_visited) {
        if (r < 0 || r >= m || c < 0 || c >= n || grid[r][c] == 0 || blocked_cells[r][c] || current_visited[r][c]) {
            return false;
        }
        if (r == m - 1 && c == n - 1) {
            return true;
        }

        current_visited[r][c] = true;

        if (pathExistsRecursive(r, c + 1, m, n, grid, blocked_cells, current_visited)) {
            return true;
        }
        if (pathExistsRecursive(r + 1, c, m, n, grid, blocked_cells, current_visited)) {
            return true;
        }

        return false;
    }

    bool disconnectPath(std::vector<std::vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();

        if (m == 1 && n == 1) {
            return true;
        }

        std::vector<std::vector<bool>> path1_cells(m, std::vector<bool>(n, false));
        if (!findAndMarkPath(0, 0, m, n, grid, path1_cells)) {
            return true;
        }

        std::vector<std::vector<bool>> blocked_for_second_path(m, std::vector<bool>(n, false));
        for (int r = 0; r < m; ++r) {
            for (int c = 0; c < n; ++c) {
                if (path1_cells[r][c] && !((r == 0 && c == 0) || (r == m - 1 && c == n - 1))) {
                    blocked_for_second_path[r][c] = true;
                }
            }
        }

        std::vector<std::vector<bool>> current_visited_for_second_path(m, std::vector<bool>(n, false));
        if (pathExistsRecursive(0, 0, m, n, grid, blocked_for_second_path, current_visited_for_second_path)) {
            return false;
        } else {
            return true;
        }
    }
};