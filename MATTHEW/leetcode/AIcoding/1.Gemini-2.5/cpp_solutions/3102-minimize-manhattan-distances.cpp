#include <vector>
#include <algorithm>
#include <climits>

class Solution {
public:
    int minimizeManhattanDistance(std::vector<std::vector<int>>& points) {
        int n = points.size();
        if (n <= 2) {
            return 0;
        }

        std::vector<std::vector<std::pair<int, int>>> all_transformed_values(16);

        for (int k = 0; k < 16; ++k) {
            std::vector<int> coeffs(4);
            for (int d = 0; d < 4; ++d) {
                if ((k >> d) & 1) {
                    coeffs[d] = -1;
                } else {
                    coeffs[d] = 1;
                }
            }

            for (int i = 0; i < n; ++i) {
                int current_val = 0;
                for (int d = 0; d < 4; ++d) {
                    current_val += coeffs[d] * points[i][d];
                }
                all_transformed_values[k].push_back({current_val, i});
            }
            std::sort(all_transformed_values[k].begin(), all_transformed_values[k].end());
        }

        int min_max_dist = INT_MAX;

        for (int i = 0; i < n; ++i) {
            int current_max_dist_for_removal = 0;

            for (int k = 0; k < 16; ++k) {
                int new_min_val;
                int new_max_val;

                if (all_transformed_values[k][0].second == i) {
                    new_min_val = all_transformed_values[k][1].first;
                } else {
                    new_min_val = all_transformed_values[k][0].first;
                }

                if (all_transformed_values[k][n - 1].second == i) {
                    new_max_val = all_transformed_values[k][n - 2].first;
                } else {
                    new_max_val = all_transformed_values[k][n - 1].first;
                }

                current_max_dist_for_removal = std::max(current_max_dist_for_removal, new_max_val - new_min_val);
            }
            min_max_dist = std::min(min_max_dist, current_max_dist_for_removal);
        }

        return min_max_dist;
    }
};