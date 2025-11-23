#include <vector>
#include <algorithm>
#include <limits>

class Solution {
public:
    long long maxScore(std::vector<std::vector<int>>& grid) {
        int m = grid.size();
        if (m == 0) {
            return 0;
        }
        int n = grid[0].size();
        if (n == 0) {
            return 0;
        }

        std::vector<long long> dp_prev(n);
        for (int j = 0; j < n; ++j) {
            dp_prev[j] = grid[0][j];
        }

        for (int i = 1; i < m; ++i) {
            std::vector<long long> dp_curr(n);

            std::vector<long long> max_prefix_plus_k(n);
            max_prefix_plus_k[0] = dp_prev[0] + 0;
            for (int k = 1; k < n; ++k) {
                max_prefix_plus_k[k] = std::max(max_prefix_plus_k[k-1], dp_prev[k] + k);
            }

            std::vector<long long> max_suffix_minus_k(n);
            max_suffix_minus_k[n-1] = dp_prev[n-1] - (n-1);
            for (int k = n - 2; k >= 0; --k) {
                max_suffix_minus_k[k] = std::max(max_suffix_minus_k[k+1], dp_prev[k] - k);
            }

            for (int j = 0; j < n; ++j) {
                long long max_val_from_prev_row = std::numeric_limits<long long>::min();

                // Case 1: k <= j, contribution is (dp_prev[k] + k) - j
                max_val_from_prev_row = std::max(max_val_from_prev_row, max_prefix_plus_k[j] - j);

                // Case 2: k > j, contribution is (dp_prev[k] - k) + j
                if (j + 1 < n) {
                    max_val_from_prev_row = std::max(max_val_from_prev_row, max_suffix_minus_k[j+1] + j);
                }

                dp_curr[j] = grid[i][j] + max_val_from_prev_row;
            }
            dp_prev = dp_curr;
        }

        long long max_score = std::numeric_limits<long long>::min();
        for (long long score : dp_prev) {
            max_score = std::max(max_score, score);
        }

        return max_score;
    }
};