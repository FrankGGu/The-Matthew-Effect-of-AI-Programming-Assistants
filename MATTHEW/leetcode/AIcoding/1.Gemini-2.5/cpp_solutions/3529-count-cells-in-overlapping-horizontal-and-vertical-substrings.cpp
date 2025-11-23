#include <vector>
#include <numeric> // For std::accumulate if needed, but manual sum is fine

class Solution {
public:
    int countCells(std::vector<std::vector<int>>& grid) {
        int m = grid.size();
        if (m == 0) {
            return 0;
        }
        int n = grid[0].size();
        if (n == 0) {
            return 0;
        }

        std::vector<int> row_ones_count(m, 0);
        std::vector<int> col_ones_count(n, 0);

        // First pass: Calculate the count of '1's in each row and each column.
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 1) {
                    row_ones_count[i]++;
                    col_ones_count[j]++;
                }
            }
        }

        int total_counted_cells = 0;
        // Second pass: Iterate through the grid to count cells satisfying the condition.
        // A cell (i, j) is counted if:
        // 1. grid[i][j] is '1'.
        // 2. The row 'i' contains at least two '1's (i.e., it's part of a horizontal segment of '1's of length > 1).
        // 3. The column 'j' contains at least two '1's (i.e., it's part of a vertical segment of '1's of length > 1).
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 1) {
                    if (row_ones_count[i] > 1 && col_ones_count[j] > 1) {
                        total_counted_cells++;
                    }
                }
            }
        }

        return total_counted_cells;
    }
};