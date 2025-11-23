#include <vector>
#include <algorithm> // Not strictly needed for this approach, but good to include for general utility

class Solution {
public:
    std::vector<int> findPeakGrid(std::vector<std::vector<int>>& matrix) {
        int m = matrix.size();
        int n = matrix[0].size();

        int low_row = 0;
        int high_row = m - 1;

        while (low_row <= high_row) {
            int mid_row = low_row + (high_row - low_row) / 2;

            int max_val_in_mid_row = -1; 
            int max_col_in_mid_row = 0;

            for (int j = 0; j < n; ++j) {
                if (matrix[mid_row][j] > max_val_in_mid_row) {
                    max_val_in_mid_row = matrix[mid_row][j];
                    max_col_in_mid_row = j;
                }
            }

            int top_neighbor_val = (mid_row > 0) ? matrix[mid_row - 1][max_col_in_mid_row] : -1;
            int bottom_neighbor_val = (mid_row < m - 1) ? matrix[mid_row + 1][max_col_in_mid_row] : -1;

            if (max_val_in_mid_row > top_neighbor_val && max_val_in_mid_row > bottom_neighbor_val) {
                return {mid_row, max_col_in_mid_row};
            } else if (max_val_in_mid_row < top_neighbor_val) {
                high_row = mid_row - 1;
            } else { 
                low_row = mid_row + 1;
            }
        }

        return {-1, -1}; // Should not be reached based on problem constraints (guaranteed peak)
    }
};