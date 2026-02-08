#include <vector>
#include <algorithm>
#include <climits>

class Solution {
public:
    int minimumOperations(std::vector<std::vector<int>>& grid) {
        int n = grid.size();
        int center = n / 2;

        std::vector<int> y_counts(3, 0);
        std::vector<int> non_y_counts(3, 0);

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if ((j == i && i <= center) || (j == n - 1 - i && i < center) || (j == center && i >= center)) {
                    y_counts[grid[i][j]]++;
                } else {
                    non_y_counts[grid[i][j]]++;
                }
            }
        }

        int y_part_size = y_counts[0] + y_counts[1] + y_counts[2];
        int non_y_part_size = non_y_counts[0] + non_y_counts[1] + non_y_counts[2];

        int min_ops = INT_MAX;

        for (int y_val = 0; y_val <= 2; ++y_val) {
            for (int non_y_val = 0; non_y_val <= 2; ++non_y_val) {
                if (y_val == non_y_val) {
                    continue;
                }

                int current_ops = (y_part_size - y_counts[y_val]) + (non_y_part_size - non_y_counts[non_y_val]);
                min_ops = std::min(min_ops, current_ops);
            }
        }

        return min_ops;
    }
};