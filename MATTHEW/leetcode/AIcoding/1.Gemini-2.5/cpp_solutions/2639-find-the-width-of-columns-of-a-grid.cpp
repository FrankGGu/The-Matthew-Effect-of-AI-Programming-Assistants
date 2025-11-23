#include <vector>
#include <string>
#include <algorithm>

class Solution {
public:
    std::vector<int> findColumnWidth(std::vector<std::vector<int>>& grid) {
        int rows = grid.size();
        int cols = grid[0].size();

        std::vector<int> result(cols);

        for (int j = 0; j < cols; ++j) {
            int max_width_for_col_j = 0;
            for (int i = 0; i < rows; ++i) {
                int current_num = grid[i][j];
                int current_width = std::to_string(current_num).length();
                max_width_for_col_j = std::max(max_width_for_col_j, current_width);
            }
            result[j] = max_width_for_col_j;
        }

        return result;
    }
};