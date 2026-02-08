class Solution {
public:
    void dfs(std::vector<std::vector<int>>& grid, int r, int c, int m, int n) {
        if (r < 0 || r >= m || c < 0 || c >= n || grid[r][c] != 1) {
            return;
        }

        grid[r][c] = 2; // Mark as visited and connected to boundary

        dfs(grid, r + 1, c, m, n);
        dfs(grid, r - 1, c, m, n);
        dfs(grid, r, c + 1, m, n);
        dfs(grid, r, c - 1, m, n);
    }

    int numberOfEnclaves(std::vector<std::vector<int>>& grid) {
        int m = grid.size();
        if (m == 0) return 0;
        int n = grid[0].size();
        if (n == 0) return 0;

        // Traverse boundary cells and start DFS for '1's
        // Top and bottom rows
        for (int j = 0; j < n; ++j) {
            if (grid[0][j] == 1) {
                dfs(grid, 0, j, m, n);
            }
            if (grid[m - 1][j] == 1) {
                dfs(grid, m - 1, j, m, n);
            }
        }

        // Left and right columns (excluding corners already covered)
        for (int i = 1; i < m - 1; ++i) {
            if (grid[i][0] == 1) {
                dfs(grid, i, 0, m, n);
            }
            if (grid[i][n - 1] == 1) {
                dfs(grid, i, n - 1, m, n);
            }
        }

        int enclaves = 0;
        // Count remaining '1's which are enclaves
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 1) {
                    enclaves++;
                }
            }
        }

        return enclaves;
    }
};