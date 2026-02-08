#include <vector>
#include <algorithm>

class Solution {
public:
    long long countFertilePyramids(std::vector<std::vector<int>>& grid) {
        int M = grid.size();
        int N = grid[0].size();

        std::vector<std::vector<int>> dp_up(M, std::vector<int>(N, 0));

        for (int r = M - 1; r >= 0; --r) {
            for (int c = 0; c < N; ++c) {
                if (grid[r][c] == 0) {
                    dp_up[r][c] = 0;
                } else {
                    dp_up[r][c] = 1;
                    if (r + 1 < M && c - 1 >= 0 && c + 1 < N) {
                        if (grid[r+1][c-1] == 1 && grid[r+1][c] == 1 && grid[r+1][c+1] == 1) {
                            dp_up[r][c] = 1 + std::min(dp_up[r+1][c-1], dp_up[r+1][c+1]);
                        }
                    }
                }
            }
        }

        std::vector<std::vector<int>> dp_down(M, std::vector<int>(N, 0));

        for (int r = 0; r < M; ++r) {
            for (int c = 0; c < N; ++c) {
                if (grid[r][c] == 0) {
                    dp_down[r][c] = 0;
                } else {
                    dp_down[r][c] = 1;
                    if (r - 1 >= 0 && c - 1 >= 0 && c + 1 < N) {
                        if (grid[r-1][c-1] == 1 && grid[r-1][c] == 1 && grid[r-1][c+1] == 1) {
                            dp_down[r][c] = 1 + std::min(dp_down[r-1][c-1], dp_down[r-1][c+1]);
                        }
                    }
                }
            }
        }

        long long total_fertile_pyramids = 0;

        for (int r = 0; r < M; ++r) {
            for (int c = 0; c < N; ++c) {
                total_fertile_pyramids += std::max(0, dp_up[r][c] - 1);
            }
        }

        for (int r = 0; r < M; ++r) {
            for (int c = 0; c < N; ++c) {
                total_fertile_pyramids += std::max(0, dp_down[r][c] - 1);
            }
        }

        return total_fertile_pyramids;
    }
};