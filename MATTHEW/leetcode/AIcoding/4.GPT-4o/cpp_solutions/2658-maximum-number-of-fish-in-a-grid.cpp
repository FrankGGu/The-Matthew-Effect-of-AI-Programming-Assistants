class Solution {
public:
    int maxFish(vector<vector<int>>& grid) {
        int maxFishCount = 0;
        int rows = grid.size();
        int cols = grid[0].size();

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                if (grid[i][j] > 0) {
                    maxFishCount = max(maxFishCount, dfs(grid, i, j));
                }
            }
        }

        return maxFishCount;
    }

private:
    int dfs(vector<vector<int>>& grid, int i, int j) {
        if (i < 0 || i >= grid.size() || j < 0 || j >= grid[0].size() || grid[i][j] == 0) {
            return 0;
        }

        int fishCount = grid[i][j];
        int temp = grid[i][j];
        grid[i][j] = 0; // Mark as visited

        fishCount += dfs(grid, i + 1, j);
        fishCount += dfs(grid, i - 1, j);
        fishCount += dfs(grid, i, j + 1);
        fishCount += dfs(grid, i, j - 1);

        grid[i][j] = temp; // Unmark
        return fishCount;
    }
};