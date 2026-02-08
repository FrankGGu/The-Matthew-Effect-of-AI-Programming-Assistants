#include <vector>
#include <iostream>

class Solution {
public:
    std::vector<std::vector<int>> transpose(const std::vector<std::vector<int>>& matrix) {
        int rows = matrix.size();
        int cols = matrix[0].size();
        std::vector<std::vector<int>> result(cols, std::vector<int>(rows));
        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                result[j][i] = matrix[i][j];
            }
        }
        return result;
    }
};