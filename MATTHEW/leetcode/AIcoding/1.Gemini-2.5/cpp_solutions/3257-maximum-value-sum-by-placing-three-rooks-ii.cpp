#include <vector>
#include <algorithm>
#include <limits> // For std::numeric_limits

class Solution {
public:
    long long maxTriplets(std::vector<std::vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();

        // Transpose the grid if m > n to ensure the outer loops iterate over the smaller dimension.
        // This optimizes the O(min(m,n)^3 * max(m,n)) complexity.
        bool transposed = false;
        if (m > n) {
            transposed = true;
            std::vector<std::vector<int>> temp_grid(n, std::vector<int>(m));
            for (int i = 0; i < m; ++i) {
                for (int j = 0; j < n; ++j) {
                    temp_grid[j][i] = grid[i][j];
                }
            }
            grid = temp_grid;
            std::swap(m, n); // m is now the smaller dimension, n is the larger
        }

        long long max_sum = std::numeric_limits<long long>::min(); // Initialize with smallest possible long long value

        // If there are fewer than 3 rows, it's impossible to place 3 rooks in distinct rows.
        // In this case, max_sum will remain its initial minimum value.
        if (m < 3) {
            return max_sum;
        }

        // Iterate over all combinations of three distinct rows (r1, r2, r3)
        for (int r1 = 0; r1 < m; ++r1) {
            for (int r2 = r1 + 1; r2 < m; ++r2) {
                for (int r3 = r2 + 1; r3 < m; ++r3) {
                    // dp[mask] stores the maximum sum achieved by placing 'popcount(mask)' rooks
                    // in rows (r1, r2, r3) according to 'mask' (bit 0 for r1, bit 1 for r2, bit 2 for r3),
                    // where each rook is in a distinct column.
                    std::vector<long long> dp(1 << 3, std::numeric_limits<long long>::min());
                    dp[0] = 0; // Base case: 0 sum with 0 rooks (no rows covered)

                    // Iterate through each column to find the best three distinct columns for these three rows
                    for (int j = 0; j < n; ++j) {
                        std::vector<long long> next_dp = dp; // Initialize next_dp with current dp values (option to not use current column j)

                        long long val1 = grid[r1][j];
                        long long val2 = grid[r2][j];
                        long long val3 = grid[r3][j];

                        // Iterate through all possible previous masks
                        for (int mask = 0; mask < (1 << 3); ++mask) {
                            if (dp[mask] == std::numeric_limits<long long>::min()) { // If this state is unreachable
                                continue;
                            }

                            // Try placing a rook at (r1, j)
                            if (!(mask & (1 << 0))) { // If row r1 is not yet covered by a rook
                                next_dp[mask | (1 << 0)] = std::max(next_dp[mask | (1 << 0)], dp[mask] + val1);
                            }

                            // Try placing a rook at (r2, j)
                            if (!(mask & (1 << 1))) { // If row r2 is not yet covered by a rook
                                next_dp[mask | (1 << 1)] = std::max(next_dp[mask | (1 << 1)], dp[mask] + val2);
                            }

                            // Try placing a rook at (r3, j)
                            if (!(mask & (1 << 2))) { // If row r3 is not yet covered by a rook
                                next_dp[mask | (1 << 2)] = std::max(next_dp[mask | (1 << 2)], dp[mask] + val3);
                            }
                        }
                        dp = next_dp; // Update dp for the next column
                    }
                    // After processing all columns, dp[(1<<3)-1] (i.e., dp[7])
                    // will contain the maximum sum for these three fixed rows using three distinct columns.
                    max_sum = std::max(max_sum, dp[(1 << 3) - 1]);
                }
            }
        }

        return max_sum;
    }
};