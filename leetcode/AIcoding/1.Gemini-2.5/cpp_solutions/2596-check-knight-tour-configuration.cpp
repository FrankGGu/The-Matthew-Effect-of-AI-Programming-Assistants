#include <vector>
#include <cmath>

class Solution {
public:
    bool checkValidGrid(std::vector<std::vector<int>>& grid) {
        int n = grid.size();

        if (grid[0][0] != 0) {
            return false;
        }

        std::vector<std::pair<int, int>> pos(n * n);
        for (int r = 0; r < n; ++r) {
            for (int c = 0; c < n; ++c) {
                pos[grid[r][c]] = {r, c};
            }
        }

        for (int i = 0; i < n * n - 1; ++i) {
            int r1 = pos[i].first;
            int c1 = pos[i].second;

            int r2 = pos[i+1].first;
            int c2 = pos[i+1].second;

            int dr_abs = std::abs(r1 - r2);
            int dc_abs = std::abs(c1 - c2);

            if (!((dr_abs == 1 && dc_abs == 2) || (dr_abs == 2 && dc_abs == 1))) {
                return false;
            }
        }

        return true;
    }
};