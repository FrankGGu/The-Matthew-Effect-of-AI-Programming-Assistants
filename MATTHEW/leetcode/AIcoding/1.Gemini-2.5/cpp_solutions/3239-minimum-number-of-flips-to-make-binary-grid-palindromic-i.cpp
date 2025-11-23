#include <vector>
#include <numeric>

class Solution {
public:
    int minimumFlips(std::vector<std::vector<int>>& grid) {
        int rows = grid.size();
        int cols = grid[0].size();
        int flips = 0;

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                int symmetric_i = rows - 1 - i;
                int symmetric_j = cols - 1 - j;

                // Process each pair of symmetric cells only once.
                // We check if the current cell (i, j) comes "before" its symmetric counterpart
                // (symmetric_i, symmetric_j) in lexicographical order.
                if (i < symmetric_i || (i == symmetric_i && j < symmetric_j)) {
                    if (grid[i][j] != grid[symmetric_i][symmetric_j]) {
                        flips++;
                    }
                }
            }
        }
        return flips;
    }
};