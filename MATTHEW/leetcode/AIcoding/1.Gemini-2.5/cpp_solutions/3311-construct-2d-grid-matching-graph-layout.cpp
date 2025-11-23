#include <vector>

class Solution {
public:
    std::vector<std::vector<int>> construct2DArray(std::vector<int>& original, int m, int n) {
        int originalSize = original.size();
        if (originalSize != m * n) {
            return {};
        }

        std::vector<std::vector<int>> grid(m, std::vector<int>(n));

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                grid[i][j] = original[i * n + j];
            }
        }

        return grid;
    }
};