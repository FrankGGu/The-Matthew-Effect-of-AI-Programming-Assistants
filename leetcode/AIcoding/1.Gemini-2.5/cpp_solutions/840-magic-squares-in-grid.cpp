#include <vector>
#include <numeric>
#include <set>

class Solution {
public:
    bool isMagic(int r, int c, const std::vector<std::vector<int>>& grid) {
        std::vector<bool> seen(10, false);
        for (int i = 0; i < 3; ++i) {
            for (int j = 0; j < 3; ++j) {
                int val = grid[r + i][c + j];
                if (val < 1 || val > 9 || seen[val]) {
                    return false;
                }
                seen[val] = true;
            }
        }

        // Check sums (all must be 15)
        // Rows
        if (grid[r][c] + grid[r][c+1] + grid[r][c+2] != 15) return false;
        if (grid[r+1][c] + grid[r+1][c+1] + grid[r+1][c+2] != 15) return false;
        if (grid[r+2][c] + grid[r+2][c+1] + grid[r+2][c+2] != 15) return false;

        // Columns
        if (grid[r][c] + grid[r+1][c] + grid[r+2][c] != 15) return false;
        if (grid[r][c+1] + grid[r+1][c+1] + grid[r+2][c+1] != 15) return false;
        if (grid[r][c+2] + grid[r+1][c+2] + grid[r+2][c+2] != 15) return false;

        // Diagonals
        if (grid[r][c] + grid[r+1][c+1] + grid[r+2][c+2] != 15) return false;
        if (grid[r][c+2] + grid[r+1][c+1] + grid[r+2][c] != 15) return false;

        return true;
    }

    int numMagicSquaresInside(std::vector<std::vector<int>>& grid) {
        int R = grid.size();
        if (R < 3) return 0;
        int C = grid[0].size();
        if (C < 3) return 0;

        int count = 0;
        for (int r = 0; r <= R - 3; ++r) {
            for (int c = 0; c <= C - 3; ++c) {
                if (isMagic(r, c, grid)) {
                    count++;
                }
            }
        }
        return count;
    }
};