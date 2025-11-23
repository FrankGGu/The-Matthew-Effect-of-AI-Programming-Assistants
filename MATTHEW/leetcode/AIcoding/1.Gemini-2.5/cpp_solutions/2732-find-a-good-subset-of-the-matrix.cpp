#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<int> goodSubsetofBinaryMatrix(std::vector<std::vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();
        std::vector<int> mask_to_idx(1 << n, -1);

        for (int i = 0; i < m; ++i) {
            int current_mask = 0;
            for (int j = 0; j < n; ++j) {
                current_mask |= (grid[i][j] << j);
            }

            if (current_mask == 0) {
                return {i};
            }

            for (int other_mask = 1; other_mask < (1 << n); ++other_mask) {
                if (mask_to_idx[other_mask] != -1) {
                    if ((current_mask & other_mask) == 0) {
                        return {mask_to_idx[other_mask], i};
                    }
                }
            }

            if (mask_to_idx[current_mask] == -1) {
                mask_to_idx[current_mask] = i;
            }
        }

        return {};
    }
};