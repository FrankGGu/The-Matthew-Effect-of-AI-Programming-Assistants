#include <vector>
#include <numeric>

class Solution {
public:
    int minDays(std::vector<std::vector<int>>& grid) {
        m = grid.size();
        n = grid[0].size();

        if (countIslands(grid) != 1) {
            return 0;
        }

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 1) {
                    grid[i][j] = 0;
                    if (countIslands(grid) != 1) {
                        return 1;
                    }
                    grid[i][j] = 1;
                }
            }
        }

        return 2;
    }

private:
    int m, n;
    int dr[4] = {-1, 1, 0, 0};
    int dc[4] = {0, 0, -1, 1};

    void dfs(int r, int c, std::vector<std::vector<int>>& grid, std::vector<std::vector<bool>>& visited) {
        if (r < 0 || r >= m || c < 0 || c >= n || grid[r][c] == 0 || visited[r][c]) {
            return;
        }
        visited[r][c] = true;
        for (int i = 0; i < 4; ++i) {
            dfs(r + dr[i], c + dc[i], grid, visited);
        }
    }

    int countIslands(std::vector<std::vector<int>>& grid) {
        std::vector<std::vector<bool>> visited(m, std::vector<bool>(n, false));
        int count = 0;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 1 && !visited[i][j]) {
                    count++;
                    dfs(i, j, grid, visited);
                }
            }
        }
        return count;
    }
};