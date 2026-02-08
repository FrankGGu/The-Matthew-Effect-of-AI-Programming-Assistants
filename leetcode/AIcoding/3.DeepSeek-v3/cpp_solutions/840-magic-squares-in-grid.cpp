class Solution {
public:
    int numMagicSquaresInside(vector<vector<int>>& grid) {
        int res = 0;
        for (int i = 0; i + 2 < grid.size(); ++i) {
            for (int j = 0; j + 2 < grid[0].size(); ++j) {
                if (isMagic(grid, i, j)) {
                    ++res;
                }
            }
        }
        return res;
    }

private:
    bool isMagic(vector<vector<int>>& grid, int x, int y) {
        vector<bool> visited(10, false);
        for (int i = x; i < x + 3; ++i) {
            for (int j = y; j < y + 3; ++j) {
                if (grid[i][j] < 1 || grid[i][j] > 9 || visited[grid[i][j]]) {
                    return false;
                }
                visited[grid[i][j]] = true;
            }
        }
        int sum = grid[x][y] + grid[x][y + 1] + grid[x][y + 2];
        if (grid[x + 1][y] + grid[x + 1][y + 1] + grid[x + 1][y + 2] != sum ||
            grid[x + 2][y] + grid[x + 2][y + 1] + grid[x + 2][y + 2] != sum ||
            grid[x][y] + grid[x + 1][y] + grid[x + 2][y] != sum ||
            grid[x][y + 1] + grid[x + 1][y + 1] + grid[x + 2][y + 1] != sum ||
            grid[x][y + 2] + grid[x + 1][y + 2] + grid[x + 2][y + 2] != sum ||
            grid[x][y] + grid[x + 1][y + 1] + grid[x + 2][y + 2] != sum ||
            grid[x][y + 2] + grid[x + 1][y + 1] + grid[x + 2][y] != sum) {
            return false;
        }
        return true;
    }
};