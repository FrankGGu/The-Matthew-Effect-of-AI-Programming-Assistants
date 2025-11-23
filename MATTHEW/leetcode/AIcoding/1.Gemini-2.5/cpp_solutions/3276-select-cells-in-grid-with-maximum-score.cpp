#include <vector>
#include <algorithm>
#include <numeric>

class Solution {
public:
    int maxScore(std::vector<std::vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();

        std::vector<std::vector<int>> g = grid;

        if (m > n) {
            std::swap(m, n);
            g.assign(m, std::vector<int>(n));
            for (int i = 0; i < m; ++i) {
                for (int j = 0; j < n; ++j) {
                    g[i][j] = grid[j][i];
                }
            }
        }

        std::vector<int> valid_masks;
        for (int mask = 0; mask < (1 << m); ++mask) {
            if ((mask & (mask << 1)) == 0) {
                valid_masks.push_back(mask);
            }
        }

        std::vector<std::vector<int>> scores(n, std::vector<int>(1 << m, 0));
        for (int c = 0; c < n; ++c) {
            for (int mask : valid_masks) {
                int current_score = 0;
                for (int r = 0; r < m; ++r) {
                    if ((mask >> r) & 1) {
                        current_score += g[r][c];
                    }
                }
                scores[c][mask] = current_score;
            }
        }

        std::vector<std::vector<int>> dp(n, std::vector<int>(1 << m, 0));
        for (int mask : valid_masks) {
            dp[0][mask] = scores[0][mask];
        }

        for (int c = 1; c < n; ++c) {
            std::vector<int> max_so_far = dp[c - 1];
            for (int i = 0; i < m; ++i) {
                for (int s_mask = 0; s_mask < (1 << m); ++s_mask) {
                    if ((s_mask >> i) & 1) {
                        max_so_far[s_mask] = std::max(max_so_far[s_mask], max_so_far[s_mask ^ (1 << i)]);
                    }
                }
            }

            for (int mask : valid_masks) {
                int complement_mask = ((1 << m) - 1) ^ mask;
                dp[c][mask] = scores[c][mask] + max_so_far[complement_mask];
            }
        }

        int max_total_score = 0;
        if (n > 0) {
            for (int mask = 0; mask < (1 << m); ++mask) {
                max_total_score = std::max(max_total_score, dp[n - 1][mask]);
            }
        }

        return max_total_score;
    }
};