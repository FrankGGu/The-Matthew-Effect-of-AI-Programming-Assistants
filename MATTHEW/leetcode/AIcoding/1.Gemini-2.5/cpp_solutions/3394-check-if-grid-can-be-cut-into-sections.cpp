#include <vector>
#include <numeric>

class Solution {
public:
    bool canCut(std::vector<std::vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();

        int total_ones = 0;
        std::vector<bool> row_has_one(m, false);
        std::vector<bool> col_has_one(n, false);

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 1) {
                    total_ones++;
                    row_has_one[i] = true;
                    col_has_one[j] = true;
                }
            }
        }

        if (total_ones == 0) {
            return false;
        }

        int rows_with_ones_count = 0;
        for (bool has_one : row_has_one) {
            if (has_one) {
                rows_with_ones_count++;
            }
        }

        int cols_with_ones_count = 0;
        for (bool has_one : col_has_one) {
            if (has_one) {
                cols_with_ones_count++;
            }
        }

        if ((long long)rows_with_ones_count * cols_with_ones_count != total_ones) {
            return false;
        }

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 1) {
                    if (!row_has_one[i] || !col_has_one[j]) {
                        return false; 
                    }
                } else {
                    if (row_has_one[i] && col_has_one[j]) {
                        return false;
                    }
                }
            }
        }

        return true;
    }
};