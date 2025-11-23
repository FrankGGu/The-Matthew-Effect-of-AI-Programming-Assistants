#include <vector>
#include <algorithm> // For std::min

class Solution {
public:
    int minPathSum(std::vector<std::vector<int>>& grid) {
        int m = grid.size();
        if (m == 0) {
            return 0;
        }
        int n = grid[0].size();
        if (n == 0) {
            return 0;
        }

        // Initialize first row
        for (int j = 1; j < n; ++j) {
            grid[0][j] += grid[0][j-1];
        }

        // Initialize first column
        for (int i = 1; i < m; ++i) {
            grid[i][0] += grid[i-1][0];
        }

        // Fill the rest of the grid
        for (int i = 1; i < m; ++i) {
            for (int j = 1; j < n; ++j) {
                grid[i][j] += std::min(grid[i-1][j], grid[i][j-1]);
            }
        }

        return grid[m-1][n-1];
    }
};