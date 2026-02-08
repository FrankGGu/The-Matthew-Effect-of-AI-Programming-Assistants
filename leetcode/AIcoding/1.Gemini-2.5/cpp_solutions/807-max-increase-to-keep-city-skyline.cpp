#include <vector>
#include <algorithm>

class Solution {
public:
    int maxIncreaseKeepingSkyline(std::vector<std::vector<int>>& grid) {
        int n = grid.size();
        if (n == 0) {
            return 0;
        }
        int m = grid[0].size();

        std::vector<int> rowMax(n, 0);
        std::vector<int> colMax(m, 0);

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                rowMax[i] = std::max(rowMax[i], grid[i][j]);
                colMax[j] = std::max(colMax[j], grid[i][j]);
            }
        }

        int totalIncrease = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                totalIncrease += std::min(rowMax[i], colMax[j]) - grid[i][j];
            }
        }

        return totalIncrease;
    }
};