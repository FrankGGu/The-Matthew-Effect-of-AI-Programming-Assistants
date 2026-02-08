#include <vector>
#include <algorithm>

class Solution {
public:
    int countSquares(std::vector<std::vector<int>>& matrix) {
        int rows = matrix.size();
        if (rows == 0) {
            return 0;
        }
        int cols = matrix[0].size();
        if (cols == 0) {
            return 0;
        }

        int totalSquares = 0;

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                if (matrix[i][j] == 1) {
                    if (i > 0 && j > 0) {
                        matrix[i][j] = 1 + std::min({matrix[i - 1][j], matrix[i][j - 1], matrix[i - 1][j - 1]});
                    }
                    totalSquares += matrix[i][j];
                }
            }
        }

        return totalSquares;
    }
};