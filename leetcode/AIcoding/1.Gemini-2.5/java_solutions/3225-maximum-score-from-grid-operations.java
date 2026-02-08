import java.util.Arrays;

class Solution {
    public long maxScore(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;

        // dp[c] stores the maximum score to reach cell (current_row, c)
        // We use a 1D array to optimize space, only keeping track of the previous row's scores.
        long[] dp = new long[n]; 

        // Initialize dp for the first row.
        // The score to reach a cell in the first row is just its value.
        for (int c = 0; c < n; c++) {
            dp[c] = grid[0][c];
        }

        // Iterate for subsequent rows starting from the second row (r=1).
        for (int r = 1; r < m; r++) {
            long[] next_dp = new long[n]; // Stores scores for the current row (r)

            // Calculate max_f_prefix[j] = max_{0 <= k <= j} (dp[k] + k)
            // This array helps in efficiently finding the maximum of (dp[prev_c] - (c - prev_c))
            // for all prev_c such that 0 <= prev_c <= c.
            long[] max_f_prefix = new long[n];
            long current_max_f = Long.MIN_VALUE; // Initialize with smallest possible long value
            for (int j = 0; j < n; j++) {
                current_max_f = Math.max(current_max_f, dp[j] + j);
                max_f_prefix[j] = current_max_f;
            }

            // Calculate max_g_suffix[j] = max_{j <= k < n} (dp[k] - k)
            // This array helps in efficiently finding the maximum of (dp[prev_c] - (prev_c - c))
            // for all prev_c such that c < prev_c < n.
            long[] max_g_suffix = new long[n];
            long current_max_g = Long.MIN_VALUE; // Initialize with smallest possible long value
            for (int j = n - 1; j >= 0; j--) {
                current_max_g = Math.max(current_max_g, dp[j] - j);
                max_g_suffix[j] = current_max_g;
            }

            // Compute next_dp for the current row (r)
            for (int c = 0; c < n; c++) {
                // Term for previous columns prev_c such that 0 <= prev_c <= c:
                // We want max(dp[prev_c] - |prev_c - c|) = max(dp[prev_c] - (c - prev_c))
                // = max(dp[prev_c] + prev_c) - c
                long term_from_left_or_same = max_f_prefix[c] - c;

                // Term for previous columns prev_c such that c < prev_c < n:
                // We want max(dp[prev_c] - |prev_c - c|) = max(dp[prev_c] - (prev_c - c))
                // = max(dp[prev_c] - prev_c) + c
                long term_from_right = Long.MIN_VALUE;
                // Check if there are any columns to the right (prev_c > c)
                if (c + 1 < n) {
                    term_from_right = max_g_suffix[c + 1] + c;
                }

                // The maximum score to reach (r, c) is grid[r][c] plus the maximum of these two terms.
                next_dp[c] = grid[r][c] + Math.max(term_from_left_or_same, term_from_right);
            }
            // Update dp to be the scores for the current row for the next iteration.
            dp = next_dp;
        }

        // After iterating through all rows, the maximum score will be the maximum value in the last row's dp array.
        long max_score = Long.MIN_VALUE; // Initialize with smallest possible long value
        for (long score : dp) {
            max_score = Math.max(max_score, score);
        }

        return max_score;
    }
}