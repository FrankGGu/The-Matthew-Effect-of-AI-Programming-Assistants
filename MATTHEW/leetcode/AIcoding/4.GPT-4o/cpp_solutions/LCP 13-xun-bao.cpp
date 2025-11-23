class Solution {
public:
    int getMaxGold(vector<vector<int>>& grid) {
        int maxGold = 0;
        int rows = grid.size();
        int cols = grid[0].size();

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (grid[i][j] > 0) {
                    maxGold = max(maxGold, collectGold(grid, i, j));
                }
            }
        }
        return maxGold;
    }

    int collectGold(vector<vector<int>>& grid, int x, int y) {
        if (x < 0 || x >= grid.size() || y < 0 || y >= grid[0].size() || grid[x][y] == 0) {
            return 0;
        }

        int gold = grid[x][y];
        grid[x][y] = 0; // mark as visited
        int maxGold = gold;

        maxGold = max(maxGold, gold + collectGold(grid, x + 1, y));
        maxGold = max(maxGold, gold + collectGold(grid, x - 1, y));
        maxGold = max(maxGold, gold + collectGold(grid, x, y + 1));
        maxGold = max(maxGold, gold + collectGold(grid, x, y - 1));

        grid[x][y] = gold; // backtrack
        return maxGold;
    }
};