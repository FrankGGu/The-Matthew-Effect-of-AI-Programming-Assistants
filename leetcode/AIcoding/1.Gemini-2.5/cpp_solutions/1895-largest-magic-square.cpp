#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int largestMagicSquare(std::vector<std::vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();

        std::vector<std::vector<long long>> row_prefix(m, std::vector<long long>(n, 0));
        std::vector<std::vector<long long>> col_prefix(m, std::vector<long long>(n, 0));
        std::vector<std::vector<long long>> diag1_prefix(m, std::vector<long long>(n, 0));
        std::vector<std::vector<long long>> diag2_prefix(m, std::vector<long long>(n, 0));

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                row_prefix[i][j] = grid[i][j] + (j > 0 ? row_prefix[i][j-1] : 0);
                col_prefix[i][j] = grid[i][j] + (i > 0 ? col_prefix[i-1][j] : 0);
                diag1_prefix[i][j] = grid[i][j] + (i > 0 && j > 0 ? diag1_prefix[i-1][j-1] : 0);
                diag2_prefix[i][j] = grid[i][j] + (i > 0 && j < n - 1 ? diag2_prefix[i-1][j+1] : 0);
            }
        }

        for (int k = std::min(m, n); k >= 1; --k) {
            for (int r = 0; r <= m - k; ++r) {
                for (int c = 0; c <= n - k; ++c) {
                    long long target_sum = row_prefix[r][c+k-1] - (c > 0 ? row_prefix[r][c-1] : 0);

                    bool is_magic = true;

                    for (int i = 0; i < k; ++i) {
                        long long current_row_sum = row_prefix[r+i][c+k-1] - (c > 0 ? row_prefix[r+i][c-1] : 0);
                        if (current_row_sum != target_sum) {
                            is_magic = false;
                            break;
                        }
                    }
                    if (!is_magic) continue;

                    for (int j = 0; j < k; ++j) {
                        long long current_col_sum = col_prefix[r+k-1][c+j] - (r > 0 ? col_prefix[r-1][c+j] : 0);
                        if (current_col_sum != target_sum) {
                            is_magic = false;
                            break;
                        }
                    }
                    if (!is_magic) continue;

                    long long prev_diag1_sum = 0;
                    if (r > 0 && c > 0) {
                        prev_diag1_sum = diag1_prefix[r-1][c-1];
                    }
                    long long diag1_sum = diag1_prefix[r+k-1][c+k-1] - prev_diag1_sum;
                    if (diag1_sum != target_sum) {
                        is_magic = false;
                    }
                    if (!is_magic) continue;

                    long long prev_diag2_sum = 0;
                    if (r > 0 && c + k < n) {
                        prev_diag2_sum = diag2_prefix[r-1][c+k];
                    }
                    long long diag2_sum = diag2_prefix[r+k-1][c] - prev_diag2_sum;
                    if (diag2_sum != target_sum) {
                        is_magic = false;
                    }

                    if (is_magic) {
                        return k;
                    }
                }
            }
        }

        return 1; 
    }
};