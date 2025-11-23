#include <vector>
#include <deque>
#include <algorithm> // For std::min, std::max

class Solution {
public:
    int minimumAbsoluteDifference(std::vector<std::vector<int>>& grid, int k) {
        int R = grid.size();
        int C = grid[0].size();

        // Step 1: Precompute row-wise minimums and maximums for 1xK windows
        // min_vals_row[i][j] stores the minimum in grid[i][j...j+k-1]
        // max_vals_row[i][j] stores the maximum in grid[i][j...j+k-1]
        std::vector<std::vector<int>> min_vals_row(R, std::vector<int>(C - k + 1));
        std::vector<std::vector<int>> max_vals_row(R, std::vector<int>(C - k + 1));

        for (int i = 0; i < R; ++i) {
            std::deque<int> min_dq; // Stores column indices for min
            std::deque<int> max_dq; // Stores column indices for max

            for (int j = 0; j < C; ++j) {
                // Remove elements from the front that are outside the current window
                if (!min_dq.empty() && min_dq.front() <= j - k) {
                    min_dq.pop_front();
                }
                if (!max_dq.empty() && max_dq.front() <= j - k) {
                    max_dq.pop_front();
                }

                // Remove elements from the back that are greater/smaller than current element
                while (!min_dq.empty() && grid[i][min_dq.back()] >= grid[i][j]) {
                    min_dq.pop_back();
                }
                while (!max_dq.empty() && grid[i][max_dq.back()] <= grid[i][j]) {
                    max_dq.pop_back();
                }

                // Add current element's index to the back
                min_dq.push_back(j);
                max_dq.push_back(j);

                // If the window is fully formed (size k), store its min/max
                if (j >= k - 1) {
                    min_vals_row[i][j - k + 1] = grid[i][min_dq.front()];
                    max_vals_row[i][j - k + 1] = grid[i][max_dq.front()];
                }
            }
        }

        // Step 2: Compute overall minimum and maximum for KxK windows
        // Iterate over all possible top-left column indices for the KxK submatrix
        int min_abs_diff = 2e9 + 7; // A sufficiently large value for initial minimum difference

        for (int j = 0; j < C - k + 1; ++j) { // j is the starting column of the KxK window
            std::deque<int> min_dq_col; // Stores row indices for min_vals_row[...][j]
            std::deque<int> max_dq_col; // Stores row indices for max_vals_row[...][j]

            for (int i = 0; i < R; ++i) { // i is the current row index
                // Remove elements from the front that are outside the current KxK window
                if (!min_dq_col.empty() && min_dq_col.front() <= i - k) {
                    min_dq_col.pop_front();
                }
                if (!max_dq_col.empty() && max_dq_col.front() <= i - k) {
                    max_dq_col.pop_front();
                }

                // Remove elements from the back that are greater/smaller than current element
                // For min_dq_col, we are finding the minimum of min_vals_row[i_curr][j]
                while (!min_dq_col.empty() && min_vals_row[min_dq_col.back()][j] >= min_vals_row[i][j]) {
                    min_dq_col.pop_back();
                }
                // For max_dq_col, we are finding the maximum of max_vals_row[i_curr][j]
                while (!max_dq_col.empty() && max_vals_row[max_dq_col.back()][j] <= max_vals_row[i][j]) {
                    max_dq_col.pop_back();
                }

                // Add current row's index to the back
                min_dq_col.push_back(i);
                max_dq_col.push_back(i);

                // If the KxK window is fully formed (i.e., we have processed k rows)
                if (i >= k - 1) {
                    int current_min_overall = min_vals_row[min_dq_col.front()][j];
                    int current_max_overall = max_vals_row[max_dq_col.front()][j];
                    min_abs_diff = std::min(min_abs_diff, current_max_overall - current_min_overall);
                }
            }
        }

        return min_abs_diff;
    }
};