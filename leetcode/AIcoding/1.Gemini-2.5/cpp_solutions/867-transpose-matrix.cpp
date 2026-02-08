#include <vector>

class Solution {
public:
    std::vector<std::vector<int>> transpose(std::vector<std::vector<int>>& matrix) {
        int R = matrix.size();
        if (R == 0) {
            return {};
        }
        int C = matrix[0].size();

        std::vector<std::vector<int>> result(C, std::vector<int>(R));

        for (int i = 0; i < R; ++i) {
            for (int j = 0; j < C; ++j) {
                result[j][i] = matrix[i][j];
            }
        }

        return result;
    }
};