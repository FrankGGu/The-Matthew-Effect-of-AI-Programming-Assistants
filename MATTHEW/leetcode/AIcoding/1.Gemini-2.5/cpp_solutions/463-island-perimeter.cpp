#include <vector>

class Solution {
public:
    int islandPerimeter(std::vector<std::vector<int>>& grid) {
        int perimeter = 0;
        int rows = grid.size();
        if (rows == 0) {
            return 0;
        }
        int cols = grid[0].size();
        if (cols == 0) {
            return 0;
        }

        for (int r = 0; r < rows; ++r) {
            for (int c = 0; c < cols; ++c) {
                if (grid[r][c] == 1) {
                    perimeter += 4; 

                    if (r > 0 && grid[r-1][c] == 1) {
                        perimeter -= 2; 
                    }
                    if (c > 0 && grid[r][c-1] == 1) {
                        perimeter -= 2; 
                    }
                }
            }
        }
        return perimeter;
    }
};