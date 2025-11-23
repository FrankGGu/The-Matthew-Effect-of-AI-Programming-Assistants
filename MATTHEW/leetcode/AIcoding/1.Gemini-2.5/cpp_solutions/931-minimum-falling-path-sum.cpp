#include <vector>
#include <algorithm>

class Solution {
public:
    int minFallingPathSum(std::vector<std::vector<int>>& matrix) {
        int n = matrix.size();
        if (n == 0) {
            return 0;
        }

        for (int i = 1; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                int min_prev_val = matrix[i-1][j];
                if (j > 0) {
                    min_prev_val = std::min(min_prev_val, matrix[i-1][j-1]);
                }
                if (j < n - 1) {
                    min_prev_val = std::min(min_prev_val, matrix[i-1][j+1]);
                }
                matrix[i][j] += min_prev_val;
            }
        }

        if (n == 1) {
            return matrix[0][0];
        }

        return *std::min_element(matrix[n-1].begin(), matrix[n-1].end());
    }
};