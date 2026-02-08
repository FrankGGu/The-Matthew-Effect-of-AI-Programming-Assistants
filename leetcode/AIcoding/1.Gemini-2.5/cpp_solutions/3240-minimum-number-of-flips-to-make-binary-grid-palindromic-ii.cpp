#include <vector>
#include <algorithm>

class Solution {
public:
    int minFlips(std::vector<std::vector<int>>& grid) {
        int m = grid.size();
        if (m == 0) {
            return 0;
        }
        int n = grid[0].size();
        if (n == 0) {
            return 0;
        }

        int flips = 0;
        for (int i = 0; i < (m + 1) / 2; ++i) {
            for (int j = 0; j < (n + 1) / 2; ++j) {
                std::vector<int> group;
                group.push_back(grid[i][j]);
                if (j != n - 1 - j) {
                    group.push_back(grid[i][n - 1 - j]);
                }
                if (i != m - 1 - i) {
                    group.push_back(grid[m - 1 - i][j]);
                }
                if (i != m - 1 - i && j != n - 1 - j) {
                    group.push_back(grid[m - 1 - i][n - 1 - j]);
                }

                int ones = 0;
                for (int val : group) {
                    ones += val;
                }

                flips += std::min(ones, (int)group.size() - ones);
            }
        }
        return flips;
    }
};