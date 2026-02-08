#include <vector>
#include <algorithm>

class Solution {
public:
    int deleteGreatestValue(std::vector<std::vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();

        for (int i = 0; i < m; ++i) {
            std::sort(grid[i].begin(), grid[i].end());
        }

        int ans = 0;
        for (int j = 0; j < n; ++j) {
            int max_val_in_col = 0;
            for (int i = 0; i < m; ++i) {
                if (grid[i][j] > max_val_in_col) {
                    max_val_in_col = grid[i][j];
                }
            }
            ans += max_val_in_col;
        }

        return ans;
    }
};