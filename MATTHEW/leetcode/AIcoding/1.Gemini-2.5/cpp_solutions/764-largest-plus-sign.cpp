#include <vector>
#include <algorithm>

class Solution {
public:
    int orderOfLargestPlusSign(int n, std::vector<std::vector<int>>& mines) {
        std::vector<std::vector<int>> grid(n, std::vector<int>(n, 1));

        for (const auto& mine : mines) {
            grid[mine[0]][mine[1]] = 0;
        }

        std::vector<std::vector<int>> left(n, std::vector<int>(n, 0));
        std::vector<std::vector<int>> right(n, std::vector<int>(n, 0));
        std::vector<std::vector<int>> up(n, std::vector<int>(n, 0));
        std::vector<std::vector<int>> down(n, std::vector<int>(n, 0));

        // Calculate left and up lengths for each cell
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 1) {
                    left[i][j] = (j > 0 ? left[i][j-1] : 0) + 1;
                    up[i][j] = (i > 0 ? up[i-1][j] : 0) + 1;
                } else {
                    left[i][j] = 0;
                    up[i][j] = 0;
                }
            }
        }

        // Calculate right and down lengths for each cell
        for (int i = n - 1; i >= 0; --i) {
            for (int j = n - 1; j >= 0; --j) {
                if (grid[i][j] == 1) {
                    right[i][j] = (j < n - 1 ? right[i][j+1] : 0) + 1;
                    down[i][j] = (i < n - 1 ? down[i+1][j] : 0) + 1;
                } else {
                    right[i][j] = 0;
                    down[i][j] = 0;
                }
            }
        }

        int max_order = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                int current_order = std::min({left[i][j], right[i][j], up[i][j], down[i][j]});
                max_order = std::max(max_order, current_order);
            }
        }

        return max_order;
    }
};