#include <vector>
#include <cmath>

class Solution {
public:
    std::vector<std::vector<int>> resultGrid(std::vector<std::vector<int>>& grid, int threshold) {
        int R = grid.size();
        int C = grid[0].size();

        std::vector<std::vector<long long>> sum_avg(R, std::vector<long long>(C, 0));
        std::vector<std::vector<int>> count(R, std::vector<int>(C, 0));

        std::vector<std::vector<int>> result = grid;

        for (int r = 0; r <= R - 3; ++r) {
            for (int c = 0; c <= C - 3; ++c) {
                bool is_valid_region = true;
                long long current_region_sum = 0;

                for (int i = 0; i < 3; ++i) {
                    for (int j = 0; j < 3; ++j) {
                        current_region_sum += grid[r + i][c + j];

                        if (j < 2) {
                            if (std::abs(grid[r + i][c + j] - grid[r + i][c + j + 1]) > threshold) {
                                is_valid_region = false;
                                break; 
                            }
                        }
                        if (i < 2) {
                            if (std::abs(grid[r + i][c + j] - grid[r + i + 1][c + j]) > threshold) {
                                is_valid_region = false;
                                break;
                            }
                        }
                    }
                    if (!is_valid_region) {
                        break;
                    }
                }

                if (is_valid_region) {
                    int region_average = static_cast<int>(current_region_sum / 9);
                    for (int i = 0; i < 3; ++i) {
                        for (int j = 0; j < 3; ++j) {
                            sum_avg[r + i][c + j] += region_average;
                            count[r + i][c + j] += 1;
                        }
                    }
                }
            }
        }

        for (int i = 0; i < R; ++i) {
            for (int j = 0; j < C; ++j) {
                if (count[i][j] > 0) {
                    result[i][j] = static_cast<int>(sum_avg[i][j] / count[i][j]);
                }
            }
        }

        return result;
    }
};