#include <vector>
#include <algorithm>
#include <utility>

class Solution {
public:
    std::pair<int, int> get_factors(int n) {
        int count2 = 0;
        int count5 = 0;
        while (n > 0 && n % 2 == 0) {
            count2++;
            n /= 2;
        }
        while (n > 0 && n % 5 == 0) {
            count5++;
            n /= 5;
        }
        return {count2, count5};
    }

    int maxTrailingZeros(std::vector<std::vector<int>>& grid) {
        int R = grid.size();
        int C = grid[0].size();

        std::vector<std::vector<int>> f2(R, std::vector<int>(C));
        std::vector<std::vector<int>> f5(R, std::vector<int>(C));

        for (int i = 0; i < R; ++i) {
            for (int j = 0; j < C; ++j) {
                std::pair<int, int> factors = get_factors(grid[i][j]);
                f2[i][j] = factors.first;
                f5[i][j] = factors.second;
            }
        }

        std::vector<std::vector<int>> prefix_row_left_2(R, std::vector<int>(C));
        std::vector<std::vector<int>> prefix_row_left_5(R, std::vector<int>(C));
        std::vector<std::vector<int>> prefix_row_right_2(R, std::vector<int>(C));
        std::vector<std::vector<int>> prefix_row_right_5(R, std::vector<int>(C));
        std::vector<std::vector<int>> prefix_col_up_2(R, std::vector<int>(C));
        std::vector<std::vector<int>> prefix_col_up_5(R, std::vector<int>(C));
        std::vector<std::vector<int>> prefix_col_down_2(R, std::vector<int>(C));
        std::vector<std::vector<int>> prefix_col_down_5(R, std::vector<int>(C));

        for (int i = 0; i < R; ++i) {
            for (int j = 0; j < C; ++j) {
                prefix_row_left_2[i][j] = f2[i][j] + (j > 0 ? prefix_row_left_2[i][j-1] : 0);
                prefix_row_left_5[i][j] = f5[i][j] + (j > 0 ? prefix_row_left_5[i][j-1] : 0);
            }
            for (int j = C - 1; j >= 0; --j) {
                prefix_row_right_2[i][j] = f2[i][j] + (j < C - 1 ? prefix_row_right_2[i][j+1] : 0);
                prefix_row_right_5[i][j] = f5[i][j] + (j < C - 1 ? prefix_row_right_5[i][j+1] : 0);
            }
        }

        for (int j = 0; j < C; ++j) {
            for (int i = 0; i < R; ++i) {
                prefix_col_up_2[i][j] = f2[i][j] + (i > 0 ? prefix_col_up_2[i-1][j] : 0);
                prefix_col_up_5[i][j] = f5[i][j] + (i > 0 ? prefix_col_up_5[i-1][j] : 0);
            }
            for (int i = R - 1; i >= 0; --i) {
                prefix_col_down_2[i][j] = f2[i][j] + (i < R - 1 ? prefix_col_down_2[i+1][j] : 0);
                prefix_col_down_5[i][j] = f5[i][j] + (i < R - 1 ? prefix_col_down_5[i+1][j] : 0);
            }
        }

        int max_zeros = 0;

        for (int r = 0; r < R; ++r) {
            for (int c = 0; c < C; ++c) {
                // Case 1: Horizontal from left, Vertical from up
                int s2_h = prefix_row_left_2[r][c];
                int s5_h = prefix_row_left_5[r][c];
                int s2_v = prefix_col_up_2[r][c];
                int s5_v = prefix_col_up_5[r][c];
                max_zeros = std::max(max_zeros, std::min(s2_h + s2_v - f2[r][c], s5_h + s5_v - f5[r][c]));

                // Case 2: Horizontal from left, Vertical from down
                s2_h = prefix_row_left_2[r][c];
                s5_h = prefix_row_left_5[r][c];
                s2_v = prefix_col_down_2[r][c];
                s5_v = prefix_col_down_5[r][c];
                max_zeros = std::max(max_zeros, std::min(s2_h + s2_v - f2[r][c], s5_h + s5_v - f5[r][c]));

                // Case 3: Horizontal from right, Vertical from up
                s2_h = prefix_row_right_2[r][c];
                s5_h = prefix_row_right_5[r][c];
                s2_v = prefix_col_up_2[r][c];
                s5_v = prefix_col_up_5[r][c];
                max_zeros = std::max(max_zeros, std::min(s2_h + s2_v - f2[r][c], s5_h + s5_v - f5[r][c]));

                // Case 4: Horizontal from right, Vertical from down
                s2_h = prefix_row_right_2[r][c];
                s5_h = prefix_row_right_5[r][c];
                s2_v = prefix_col_down_2[r][c];
                s5_v = prefix_col_down_5[r][c];
                max_zeros = std::max(max_zeros, std::min(s2_h + s2_v - f2[r][c], s5_h + s5_v - f5[r][c]));
            }
        }

        return max_zeros;
    }
};