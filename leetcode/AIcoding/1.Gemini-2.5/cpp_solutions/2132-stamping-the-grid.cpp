#include <vector>
#include <functional>

class Solution {
public:
    bool possibleToStamp(std::vector<std::vector<int>>& grid, int stampHeight, int stampWidth) {
        int m = grid.size();
        int n = grid[0].size();
        int h = stampHeight;
        int w = stampWidth;

        std::vector<std::vector<int>> pref_ones(m + 1, std::vector<int>(n + 1, 0));
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                pref_ones[i + 1][j + 1] = grid[i][j] + pref_ones[i][j + 1] + pref_ones[i + 1][j] - pref_ones[i][j];
            }
        }

        auto query_ones = [&](int r1, int c1, int r2, int c2) {
            return pref_ones[r2 + 1][c2 + 1] - pref_ones[r1][c2 + 1] - pref_ones[r2 + 1][c1] + pref_ones[r1][c1];
        };

        std::vector<std::vector<int>> can_stamp(m, std::vector<int>(n, 0));
        for (int i = 0; i <= m - h; ++i) {
            for (int j = 0; j <= n - w; ++j) {
                if (query_ones(i, j, i + h - 1, j + w - 1) == 0) {
                    can_stamp[i][j] = 1;
                }
            }
        }

        std::vector<std::vector<int>> diff(m + 1, std::vector<int>(n + 1, 0));
        for (int i = 0; i <= m - h; ++i) {
            for (int j = 0; j <= n - w; ++j) {
                if (can_stamp[i][j]) {
                    diff[i][j]++;
                    diff[i + h][j]--;
                    diff[i][j + w]--;
                    diff[i + h][j + w]++;
                }
            }
        }

        std::vector<std::vector<int>> covered(m, std::vector<int>(n, 0));
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (i > 0) diff[i][j] += diff[i - 1][j];
                if (j > 0) diff[i][j] += diff[i][j - 1];
                if (i > 0 && j > 0) diff[i][j] -= diff[i - 1][j - 1];
                covered[i][j] = (diff[i][j] > 0);
            }
        }

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 0 && !covered[i][j]) {
                    return false;
                }
            }
        }

        return true;
    }
};