#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int maximumRows(std::vector<std::vector<int>>& mat, int numSelect) {
        int m = mat.size();
        int n = mat[0].size();

        std::vector<int> row_masks(m);
        for (int i = 0; i < m; ++i) {
            int mask = 0;
            for (int j = 0; j < n; ++j) {
                if (mat[i][j] == 1) {
                    mask |= (1 << j);
                }
            }
            row_masks[i] = mask;
        }

        int max_covered_rows = 0;

        for (int i = 0; i < (1 << n); ++i) {
            if (__builtin_popcount(i) != numSelect) {
                continue;
            }

            int current_covered_rows = 0;
            for (int r_mask : row_masks) {
                if ((r_mask & (~i)) == 0) {
                    current_covered_rows++;
                }
            }
            max_covered_rows = std::max(max_covered_rows, current_covered_rows);
        }

        return max_covered_rows;
    }
};