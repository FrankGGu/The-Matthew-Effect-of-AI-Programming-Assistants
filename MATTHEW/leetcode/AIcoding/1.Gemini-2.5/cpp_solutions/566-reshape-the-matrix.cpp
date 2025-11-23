#include <vector>

class Solution {
public:
    std::vector<std::vector<int>> matrixReshape(std::vector<std::vector<int>>& mat, int r, int c) {
        int m = mat.size();
        int n = mat[0].size();

        if (m * n != r * c) {
            return mat;
        }

        std::vector<std::vector<int>> reshaped_mat(r, std::vector<int>(c));

        for (int k = 0; k < m * n; ++k) {
            int original_row = k / n;
            int original_col = k % n;

            int new_row = k / c;
            int new_col = k % c;

            reshaped_mat[new_row][new_col] = mat[original_row][original_col];
        }

        return reshaped_mat;
    }
};