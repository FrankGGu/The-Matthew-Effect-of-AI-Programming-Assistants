#include <vector>
#include <algorithm>
#include <limits>

class Solution {
public:
    int maxSumHourglass(std::vector<std::vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();

        int maxSum = std::numeric_limits<int>::min();

        for (int r = 0; r <= m - 3; ++r) {
            for (int c = 0; c <= n - 3; ++c) {
                int currentSum = 
                    grid[r][c] + grid[r][c+1] + grid[r][c+2] +
                    grid[r+1][c+1] +
                    grid[r+2][c] + grid[r+2][c+1] + grid[r+2][c+2];

                maxSum = std::max(maxSum, currentSum);
            }
        }

        return maxSum;
    }
};