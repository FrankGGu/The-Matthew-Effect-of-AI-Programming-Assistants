class Solution {
public:
    int maxFish(std::vector<std::vector<int>>& grid) {
        int rows = grid.size();
        if (rows == 0) {
            return 0;
        }
        int cols = grid[0].size();
        if (cols == 0) {
            return 0;
        }

        int max_fish_count = 0;

        for (int r = 0; r < rows; ++r) {
            for (int c = 0; c < cols; ++c) {
                if (grid[r][c] > 0) { // If it's a water cell with fish
                    max_fish_count = std::max(max_fish_count, dfs(grid, r, c, rows, cols));
                }
            }
        }
        return max_fish_count;
    }

private:
    int dfs(std::vector<std::vector<int>>& grid, int r, int c, int rows, int cols) {
        // Base cases for DFS
        if (r < 0 || r >= rows || c < 0 || c >= cols || grid[r][c] == 0) {
            return 0; // Out of bounds, or land cell, or already visited (marked 0)
        }

        int current_fish = grid[r][c];
        grid[r][c] = 0; // Mark as visited by setting to 0

        // Explore neighbors
        current_fish += dfs(grid, r + 1, c, rows, cols); // Down
        current_fish += dfs(grid, r - 1, c, rows, cols); // Up
        current_fish += dfs(grid, r, c + 1, rows, cols); // Right
        current_fish += dfs(grid, r, c - 1, rows, cols); // Left

        return current_fish;
    }
};