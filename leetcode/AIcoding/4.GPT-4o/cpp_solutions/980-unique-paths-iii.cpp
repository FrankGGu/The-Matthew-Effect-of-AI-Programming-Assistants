class Solution {
public:
    int uniquePathsIII(vector<vector<int>>& grid) {
        int startX, startY, emptyCount = 0;
        int rows = grid.size(), cols = grid[0].size();

        for (int r = 0; r < rows; ++r) {
            for (int c = 0; c < cols; ++c) {
                if (grid[r][c] == 1) {
                    startX = r;
                    startY = c;
                }
                if (grid[r][c] == 0 || grid[r][c] == 1) {
                    emptyCount++;
                }
            }
        }

        return backtrack(grid, startX, startY, emptyCount);
    }

    int backtrack(vector<vector<int>>& grid, int x, int y, int emptyCount) {
        if (x < 0 || x >= grid.size() || y < 0 || y >= grid[0].size() || grid[x][y] == -1) {
            return 0;
        }
        if (grid[x][y] == 2) {
            return emptyCount == 1 ? 1 : 0;
        }

        grid[x][y] = -1;  // mark as visited
        int paths = backtrack(grid, x + 1, y, emptyCount - 1) +
                    backtrack(grid, x - 1, y, emptyCount - 1) +
                    backtrack(grid, x, y + 1, emptyCount - 1) +
                    backtrack(grid, x, y - 1, emptyCount - 1);
        grid[x][y] = 0;  // unmark for backtracking

        return paths;
    }
};