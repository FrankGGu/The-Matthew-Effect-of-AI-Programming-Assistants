#include <stdbool.h>

#define MAX(a, b) ((a) > (b) ? (a) : (b))

int M_rows, N_cols;

int dp[8][1 << 8];

bool is_mask_valid_for_row[8][1 << 8];

int countSetBits(int n) {
    int count = 0;
    while (n > 0) {
        n &= (n - 1);
        count++;
    }
    return count;
}

void precompute_row_masks_helper(char** seats) {
    for (int r = 0; r < M_rows; ++r) {
        for (int mask = 0; mask < (1 << N_cols); ++mask) {
            bool valid = true;

            // Check for adjacent students in the same row: (mask & (mask >> 1)) must be 0
            if ((mask & (mask >> 1)) != 0) {
                valid = false;
            }

            if (valid) {
                // Check if students are placed in broken seats
                for (int c = 0; c < N_cols; ++c) {
                    // If c-th bit is set in mask AND seat[r][c] is '#'
                    if (((mask >> c) & 1) && seats[r][c] == '#') {
                        valid = false;
                        break;
                    }
                }
            }
            is_mask_valid_for_row[r][mask] = valid;
        }
    }
}

int maxStudents(char** seats, int seatsSize, int* seatsColSize) {
    M_rows = seatsSize;
    N_cols = seatsColSize[0];

    // Initialize DP table with -1 to indicate unreachable states
    for (int i = 0; i < M_rows; ++i) {
        for (int j = 0; j < (1 << N_cols); ++j) {
            dp[i][j] = -1;
        }
    }

    // Precompute valid masks for all rows
    precompute_row_masks_helper(seats);

    // Base case: Fill DP table for the first row (row 0)
    for (int mask = 0; mask < (1 << N_cols); ++mask) {
        if (is_mask_valid_for_row[0][mask]) {
            dp[0][mask] = countSetBits(mask);
        }
    }

    // Iterate through subsequent rows to fill the DP table
    for (int r = 1; r < M_rows; ++r) {
        for (int current_mask = 0; current_mask < (1 << N_cols); ++current_mask) {
            // Skip if the current mask is not valid for the current row
            if (!is_mask_valid_for_row[r][current_mask]) {
                continue;
            }

            // Iterate through all possible masks for the previous row
            for (int prev_mask = 0; prev_mask < (1 << N_cols); ++prev_mask) {
                // Skip if the previous state was unreachable
                if (dp[r-1][prev_mask] == -1) {
                    continue;
                }

                // Check compatibility between current_mask and prev_mask (no diagonal conflicts)
                // A student at (r, c) cannot have a student at (r-1, c-1) or (r-1, c+1).
                // This is checked by:
                // (current_mask & (prev_mask >> 1)) == 0  // checks (r,c) vs (r-1, c-1)
                // (current_mask & (prev_mask << 1)) == 0  // checks (r,c) vs (r-1, c+1)
                if (((current_mask & (prev_mask >> 1)) == 0) &&
                    ((current_mask & (prev_mask << 1)) == 0)) {

                    // Update dp[r][current_mask] with the maximum students found so far
                    dp[r][current_mask] = MAX(dp[r][current_mask], dp[r-1][prev_mask] + countSetBits(current_mask));
                }
            }
        }
    }

    // The final answer is the maximum value in the last row of the DP table
    int max_students = 0;
    for (int mask = 0; mask < (1 << N_cols); ++mask) {
        max_students = MAX(max_students, dp[M_rows-1][mask]);
    }

    return max_students;
}