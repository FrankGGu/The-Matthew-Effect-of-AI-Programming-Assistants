#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<std::vector<int>> largestLocal(std::vector<std::vector<int>>& grid) {
        int n = grid.size();
        int result_size = n - 2;
        std::vector<std::vector<int>> maxLocal(result_size, std::vector<int>(result_size));

        for (int i = 0; i < result_size; ++i) {
            for (int j = 0; j < result_size; ++j) {
                int current_max = 0; 
                for (int r = i; r < i + 3; ++r) {
                    for (int c = j; c < j + 3; ++c) {
                        current_max = std::max(current_max, grid[r][c]);
                    }
                }
                maxLocal[i][j] = current_max;
            }
        }
        return maxLocal;
    }
};