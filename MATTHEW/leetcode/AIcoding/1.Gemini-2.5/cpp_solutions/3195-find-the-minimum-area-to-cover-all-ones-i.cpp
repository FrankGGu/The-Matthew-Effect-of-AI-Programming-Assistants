#include <vector>
#include <string>
#include <algorithm>
#include <limits>

class Solution {
public:
    int minimumArea(std::vector<std::string>& grid) {
        int min_r = std::numeric_limits<int>::max();
        int max_r = std::numeric_limits<int>::min();
        int min_c = std::numeric_limits<int>::max();
        int max_c = std::numeric_limits<int>::min();

        int rows = grid.size();
        int cols = grid[0].size();

        bool found_one = false;

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                if (grid[i][j] == '1') {
                    min_r = std::min(min_r, i);
                    max_r = std::max(max_r, i);
                    min_c = std::min(min_c, j);
                    max_c = std::max(max_c, j);
                    found_one = true;
                }
            }
        }

        if (!found_one) {
            return 0;
        }

        long long height = max_r - min_r + 1;
        long long width = max_c - min_c + 1;

        return static_cast<int>(height * width);
    }
};