#include <vector>
#include <numeric> // Not strictly needed for this solution, but often useful

class Solution {
public:
    long long minimumOperations(int m, int n, int k, std::vector<std::vector<int>>& grid) {
        // `diff` is a 2D difference array. `diff[r][c]` stores the net change
        // in the number of active operations that start at (r, c) and propagate.
        // When an operation starts at (r_start, c_start) and affects a k x k square:
        //   diff[r_start][c_start] += 1
        //   diff[r_start][c_start + k] -= 1
        //   diff[r_start + k][c_start] -= 1
        //   diff[r_start + k][c_start + k] += 1
        //
        // We iterate the grid from bottom-right to top-left (i.e., from (m-1, n-1) to (0, 0)).
        // At each cell (i, j), we calculate the total decrease already applied to it
        // by operations that started at (x, y) where x > i or y > j.
        // This is done by effectively computing a 2D prefix sum in reverse.
        // The value `current_decrease_at_ij` represents the sum of operations
        // that are active at (i, j) and originated from cells with larger row/column indices.

        // The diff array needs to be large enough to accommodate indices up to `m-1+k` and `n-1+k`.
        // So, dimensions `m+k` by `n+k` are appropriate.
        std::vector<std::vector<long long>> diff(m + k, std::vector<long long>(n + k, 0));
        long long total_operations = 0;

        for (int i = m - 1; i >= 0; --i) {
            for (int j = n - 1; j >= 0; --j) {
                // Calculate the total decrease currently affecting grid[i][j]
                // from operations that started at (x, y) where x > i or y > j.
                // This is the cumulative effect propagating from cells (i+1, j), (i, j+1), and (i+1, j+1).
                long long current_decrease_at_ij = diff[i+1][j] + diff[i][j+1] - diff[i+1][j+1];

                // Determine how many more operations are needed starting at (i, j)
                // to make grid[i][j] zero, after accounting for `current_decrease_at_ij`.
                long long ops_to_start_at_ij = grid[i][j] - current_decrease_at_ij;

                // According to problem constraints and typical LeetCode problem patterns,
                // `ops_to_start_at_ij` must always be non-negative. If it were negative,
                // it would imply that `grid[i][j]` has been over-decreased by prior operations,
                // which should not happen if a valid solution exists and we apply minimum operations.
                // We assume it's always >= 0.

                if (ops_to_start_at_ij > 0) {
                    total_operations += ops_to_start_at_ij;

                    // Apply `ops_to_start_at_ij` operations starting at (i, j).
                    // Update the `diff` array to reflect these new operations.

                    // These operations increase the count of active operations starting at (i, j).
                    diff[i][j] += ops_to_start_at_ij;

                    // These operations stop affecting cells at row `i+k`.
                    // So, subtract their effect from `diff[i+k][j]`.
                    diff[i+k][j] -= ops_to_start_at_ij;

                    // These operations stop affecting cells at column `j+k`.
                    // So, subtract their effect from `diff[i][j+k]`.
                    diff[i][j+k] -= ops_to_start_at_ij;

                    // The subtractions at `diff[i+k][j]` and `diff[i][j+k]` cause a double subtraction
                    // for the region starting at `(i+k, j+k)`.
                    // Add back `ops_to_start_at_ij` to compensate for this double subtraction.
                    diff[i+k][j+k] += ops_to_start_at_ij;
                }
            }
        }

        return total_operations;
    }
};