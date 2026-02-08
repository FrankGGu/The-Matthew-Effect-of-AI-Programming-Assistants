#include <vector>
#include <set>
#include <algorithm>
#include <climits>

class Solution {
public:
    int maxSumSubmatrix(std::vector<std::vector<int>>& matrix, int k) {
        int rows = matrix.size();
        if (rows == 0) return 0;
        int cols = matrix[0].size();
        if (cols == 0) return 0;

        int max_sum = INT_MIN;

        bool is_row_major = (rows <= cols);

        int dim1 = is_row_major ? rows : cols;
        int dim2 = is_row_major ? cols : rows;

        for (int i = 0; i < dim1; ++i) {
            std::vector<int> current_sums(dim2, 0);

            for (int j = i; j < dim1; ++j) {
                for (int l = 0; l < dim2; ++l) {
                    if (is_row_major) {
                        current_sums[l] += matrix[j][l];
                    } else {
                        current_sums[l] += matrix[l][j];
                    }
                }

                int current_rect_sum = 0;
                std::set<int> prefix_sums;
                prefix_sums.insert(0);

                for (int sum_val : current_sums) {
                    current_rect_sum += sum_val;
                    auto it = prefix_sums.lower_bound(current_rect_sum - k);

                    if (it != prefix_sums.end()) {
                        max_sum = std::max(max_sum, current_rect_sum - *it);
                    }
                    prefix_sums.insert(current_rect_sum);
                }
            }
        }

        return max_sum;
    }
};