class Solution {
public:
    void dfs(std::vector<std::vector<int>>& grid, int r, int c, int m, int n) {
        if (r < 0 || r >= m || c < 0 || c >= n || grid[r][c] == 0) {
            return;
        }

        grid[r][c] = 0;

        dfs(grid, r + 1, c, m, n);
        dfs(grid, r - 1, c, m, n);
        dfs(grid, r, c + 1, m, n);
        dfs(grid, r, c - 1, m, n);
    }

    int countSubIslands(std::vector<std::vector<int>>& grid1, std::vector<std::vector<int>>& grid2) {
        int m = grid1.size();
        int n = grid1[0].size();

        for (int r = 0; r < m; ++r) {
            for (int c = 0; c < n; ++c) {
                if (grid2[r][c] == 1 && grid1[r][c] == 0) {
                    dfs(grid2, r, c, m, n);
                }
            }
        }

        int subIslandCount = 0;
        for (int r = 0; r < m; ++r) {
            for (int c = 0; c < n; ++c) {
                if (grid2[r][c] == 1) {
                    subIslandCount++;
                    dfs(grid2, r, c, m, n);
                }
            }
        }

        return subIslandCount;
    }
};