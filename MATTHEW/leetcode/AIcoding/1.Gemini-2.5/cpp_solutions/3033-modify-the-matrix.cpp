#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<std::vector<int>> modifiedMatrix(std::vector<std::vector<int>> matrix) {
        int m = matrix.size();
        int n = matrix[0].size();

        std::vector<int> col_maxes(n);
        for (int j = 0; j < n; ++j) {
            int max_val = -1;
            for (int i = 0; i < m; ++i) {
                max_val = std::max(max_val, matrix[i][j]);
            }
            col_maxes[j] = max_val;
        }

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (matrix[i][j] == -1) {
                    matrix[i][j] = col_maxes[j];
                }
            }
        }

        return matrix;
    }
};