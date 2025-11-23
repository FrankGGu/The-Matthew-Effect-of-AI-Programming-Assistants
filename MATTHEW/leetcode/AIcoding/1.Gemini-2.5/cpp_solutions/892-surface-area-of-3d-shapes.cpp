#include <vector>
#include <algorithm>

class Solution {
public:
    int surfaceArea(std::vector<std::vector<int>>& grid) {
        int n = grid.size();
        int totalArea = 0;

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] > 0) {
                    totalArea += (4 * grid[i][j] + 2);

                    if (i > 0) {
                        totalArea -= 2 * std::min(grid[i][j], grid[i - 1][j]);
                    }

                    if (j > 0) {
                        totalArea -= 2 * std::min(grid[i][j], grid[i][j - 1]);
                    }
                }
            }
        }

        return totalArea;
    }
};