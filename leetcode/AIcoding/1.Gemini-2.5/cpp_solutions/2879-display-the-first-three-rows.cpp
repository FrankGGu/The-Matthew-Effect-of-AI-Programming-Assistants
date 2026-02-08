#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<std::vector<int>> displayFirstThreeRows(std::vector<std::vector<int>>& matrix) {
        std::vector<std::vector<int>> result;
        int rowsToTake = std::min((int)matrix.size(), 3);

        for (int i = 0; i < rowsToTake; ++i) {
            result.push_back(matrix[i]);
        }

        return result;
    }
};