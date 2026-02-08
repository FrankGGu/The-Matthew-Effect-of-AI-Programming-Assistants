#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int getMaximumGold(vector<vector<int>>& grid) {
        int maxGold = 0;
        int rows = grid.size();
        int cols = grid[0].size();

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                if (grid[i][j] > 0) {
                    maxGold = max(maxGold, dfs(grid, i, j));
                }
            }
        }
        return maxGold;
    }

private:
    int dfs(vector<vector<int>>& grid, int r, int c) {
        int rows = grid.size();
        int cols = grid[0].size();

        if (r < 0 || r >= rows || c < 0 || c >= cols || grid[r][c] == 0) {
            return 0;
        }

        int currentGold = grid[r][c];
        grid[r][c] = 0;

        int maxFromNeighbors = 0;
        int dr[] = {0, 0, 1, -1};
        int dc[] = {1, -1, 0, 0};

        for (int i = 0; i < 4; ++i) {
            maxFromNeighbors = max(maxFromNeighbors, dfs(grid, r + dr[i], c + dc[i]));
        }

        grid[r][c] = currentGold;

        return currentGold + maxFromNeighbors;
    }
};