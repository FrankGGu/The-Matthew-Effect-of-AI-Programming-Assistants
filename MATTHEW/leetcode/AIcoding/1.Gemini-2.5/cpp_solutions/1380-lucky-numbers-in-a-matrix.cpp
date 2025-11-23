#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<int> luckyNumbers (std::vector<std::vector<int>>& matrix) {
        std::vector<int> result;
        int m = matrix.size();
        if (m == 0) {
            return result;
        }
        int n = matrix[0].size();
        if (n == 0) {
            return result;
        }

        for (int i = 0; i < m; ++i) {
            int min_val_in_row = matrix[i][0];
            int min_col_idx = 0;

            // Find minimum in current row
            for (int j = 1; j < n; ++j) {
                if (matrix[i][j] < min_val_in_row) {
                    min_val_in_row = matrix[i][j];
                    min_col_idx = j;
                }
            }

            // Check if this minimum is also maximum in its column
            bool is_max_in_col = true;
            for (int k = 0; k < m; ++k) {
                if (matrix[k][min_col_idx] > min_val_in_row) {
                    is_max_in_col = false;
                    break;
                }
            }

            if (is_max_in_col) {
                result.push_back(min_val_in_row);
            }
        }

        return result;
    }
};