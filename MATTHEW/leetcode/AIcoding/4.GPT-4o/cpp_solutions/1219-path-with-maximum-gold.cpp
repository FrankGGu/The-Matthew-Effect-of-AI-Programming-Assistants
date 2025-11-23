class Solution {
public:
    int getMaximumGold(vector<vector<int>>& grid) {
        int maxGold = 0;
        int rows = grid.size();
        int cols = grid[0].size();

        function<int(int, int)> dfs = [&](int x, int y) {
            if (x < 0 || x >= rows || y < 0 || y >= cols || grid[x][y] == 0) return 0;
            int gold = grid[x][y];
            grid[x][y] = 0; // mark as visited
            int maxGoldFromHere = gold + max({dfs(x + 1, y), dfs(x - 1, y), dfs(x, y + 1), dfs(x, y - 1)});
            grid[x][y] = gold; // unmark
            return maxGoldFromHere;
        };

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                if (grid[i][j] > 0) {
                    maxGold = max(maxGold, dfs(i, j));
                }
            }
        }
        return maxGold;
    }
};