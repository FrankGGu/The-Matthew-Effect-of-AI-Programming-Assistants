#include <vector>
#include <algorithm>

class Solution {
public:
    int largest1BorderedSquare(std::vector<std::vector<int>>& grid) {
        int m = grid.size();
        if (m == 0) return 0;
        int n = grid[0].size();
        if (n == 0) return 0;

        std::vector<std::vector<int>> left(m, std::vector<int>(n, 0));
        std::vector<std::vector<int>> up(m, std::vector<int>(n, 0));

        for (int r = 0; r < m; ++r) {
            for (int c = 0; c < n; ++c) {
                if (grid[r][c] == 1) {
                    left[r][c] = 1 + (c > 0 ? left[r][c-1] : 0);
                    up[r][c] = 1 + (r > 0 ? up[r-1][c] : 0);
                }
            }
        }

        int max_square_side = 0;

        for (int r = 0; r < m; ++r) {
            for (int c = 0; c < n; ++c) {
                if (grid[r][c] == 1) {
                    // Current cell (r, c) is the bottom-right corner of a potential square
                    // The maximum possible side length k for a square ending at (r, c)
                    // is limited by the number of consecutive 1s to its left and above.
                    int current_max_k = std::min(left[r][c], up[r][c]);

                    // Iterate downwards from current_max_k to 1
                    // to find the largest k that forms a valid 1-bordered square.
                    for (int k = current_max_k; k >= 1; --k) {
                        // Check if the top-right corner (r - k + 1, c) has at least k 1s to its left
                        // AND if the bottom-left corner (r, c - k + 1) has at least k 1s upwards.
                        if (left[r - k + 1][c] >= k && up[r][c - k + 1] >= k) {
                            max_square_side = std::max(max_square_side, k);
                            break; // Found the largest k for this (r, c), move to next cell
                        }
                    }
                }
            }
        }

        return max_square_side * max_square_side;
    }
};