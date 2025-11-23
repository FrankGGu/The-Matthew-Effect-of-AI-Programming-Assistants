#include <vector>
#include <algorithm>
#include <tuple>

class Solution {
public:
    int maxIncreasingCells(std::vector<std::vector<int>>& matrix) {
        int m = matrix.size();
        int n = matrix[0].size();

        std::vector<std::tuple<int, int, int>> cells;
        cells.reserve(m * n);

        for (int r = 0; r < m; ++r) {
            for (int c = 0; c < n; ++c) {
                cells.emplace_back(matrix[r][c], r, c);
            }
        }

        std::sort(cells.begin(), cells.end());

        std::vector<int> max_row_len(m, 0);
        std::vector<int> max_col_len(n, 0);
        int overall_max_len = 0;

        int i = 0;
        while (i < cells.size()) {
            int current_val = std::get<0>(cells[i]);
            int j = i;

            std::vector<std::pair<int, int>> current_group_coords;
            while (j < cells.size() && std::get<0>(cells[j]) == current_val) {
                current_group_coords.push_back({std::get<1>(cells[j]), std::get<2>(cells[j])});
                j++;
            }

            std::vector<int> temp_dp_vals_for_group;
            temp_dp_vals_for_group.reserve(current_group_coords.size());
            for (auto p : current_group_coords) {
                int r = p.first;
                int c = p.second;
                int val = 1 + std::max(max_row_len[r], max_col_len[c]);
                temp_dp_vals_for_group.push_back(val);
            }

            for (int k = 0; k < current_group_coords.size(); ++k) {
                int r = current_group_coords[k].first;
                int c = current_group_coords[k].second;
                int calculated_dp_val = temp_dp_vals_for_group[k];

                max_row_len[r] = std::max(max_row_len[r], calculated_dp_val);
                max_col_len[c] = std::max(max_col_len[c], calculated_dp_val);
                overall_max_len = std::max(overall_max_len, calculated_dp_val);
            }

            i = j;
        }

        return overall_max_len;
    }
};