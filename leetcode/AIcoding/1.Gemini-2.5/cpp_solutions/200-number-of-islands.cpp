class Solution {
public:
    void dfs(std::vector<std::vector<char>>& grid, int r, int c) {
        int nr = grid.size();
        int nc = grid[0].size();

        if (r < 0 || r >= nr || c < 0 || c >= nc || grid[r][c] == '0') {
            return;
        }

        grid[r][c] = '0'; // Mark as visited

        dfs(grid, r + 1, c);
        dfs(grid, r - 1, c);
        dfs(grid, r, c + 1);
        dfs(grid, r, c - 1);
    }

    int numIslands(std::vector<std::vector<char>>& grid) {
        if (grid.empty() || grid[0].empty()) {
            return 0;
        }

        int nr = grid.size();
        int nc = grid[0].size();
        int num_islands = 0;

        for (int r = 0; r < nr; ++r) {
            for (int c = 0; c < nc; ++c) {
                if (grid[r][c] == '1') {
                    num_islands++;
                    dfs(grid, r, c);
                }
            }
        }

        return num_islands;
    }
};