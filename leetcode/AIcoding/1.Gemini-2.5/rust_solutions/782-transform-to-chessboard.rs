impl Solution {
    pub fn moves_to_chessboard(board: Vec<Vec<i32>>) -> i32 {
        let n = board.len();

        // Step 1: Check the structural property of a chessboard.
        // For any 2x2 subgrid, the elements must satisfy the condition:
        // board[i][j] ^ board[i][k] ^ board[l][j] ^ board[l][k] == 0.
        // This simplifies to board[i][j] == board[i][0] ^ board[0][j] ^ board[0][0].
        // This property ensures that all rows are either identical to board[0] or its complement,
        // and all columns are either identical to the first column or its complement.
        for i in 0..n {
            for j in 0..n {
                if board[i][j] != (board[i][0] ^ board[0][j] ^ board[0][0]) {
                    return -1;
                }
            }
        }

        // Step 2: Check the counts of 0s and 1s in the first row and first column.
        // For a valid chessboard, each row/column must have a balanced number of 0s and 1s.
        // If n is even, exactly n/2 zeros and n/2 ones.
        // If n is odd, either (n-1)/2 zeros and (n+1)/2 ones, or vice-versa.
        let mut row0_ones = 0;
        let mut col0_ones = 0;
        for i in 0..n {
            if board[0][i] == 1 {
                row0_ones += 1;
            }
            if board[i][0] == 1 {
                col0_ones += 1;
            }
        }

        if n % 2 == 0 {
            // n is even, so exactly n/2 ones are required in each row/column.
            if row0_ones != n / 2 || col0_ones != n / 2 {
                return -1;
            }
        } else {
            // n is odd, so either n/2 or (n+1)/2 ones are required.
            // (n/2 in integer division gives (n-1)/2).
            if (row0_ones != n / 2 && row0_ones != (n + 1) / 2) ||
               (col0_ones != n / 2 && col0_ones != (n + 1) / 2) {
                return -1;
            }
        }

        // Helper function to calculate minimum swaps for a single row or column pattern.
        // `mismatches` is the count of elements that don't match the `0101...` pattern.
        let calculate_swaps = |mismatches: i32, n_val: i32| -> i32 {
            if n_val % 2 == 0 {
                // For even `n_val`, the number of mismatches must be even.
                // Each swap fixes two misplaced elements.
                // If `mismatches` is odd, it's impossible to achieve the target pattern.
                if mismatches % 2 != 0 {
                    return i32::MAX; // Represents an impossible state
                }
                mismatches / 2
            } else {
                // For odd `n_val`, we can target either `0101...` or `1010...`.
                // If `mismatches` is the count for `0101...`, then `n_val - mismatches`
                // is the count for `1010...`.
                // Since `n_val` is odd, one of `mismatches` or `n_val - mismatches` must be even,
                // and the other odd. We choose the pattern that requires an even number of mismatches.
                if mismatches % 2 == 0 {
                    mismatches / 2
                } else {
                    (n_val - mismatches) / 2
                }
            }
        };

        // Step 3: Calculate the minimum number of swaps.
        // We need to make the first row and first column alternate (e.g., 0101... or 1010...).
        // The total swaps will be the sum of row swaps and column swaps.
        let mut row_mismatches = 0; // Mismatches for board[i][0] vs (i % 2)
        let mut col_mismatches = 0; // Mismatches for board[0][j] vs (j % 2)

        for i in 0..n {
            if board[i][0] != (i as i32 % 2) {
                row_mismatches += 1;
            }
            if board[0][i] != (i as i32 % 2) {
                col_mismatches += 1;
            }
        }

        let row_swaps = calculate_swaps(row_mismatches, n as i32);
        let col_swaps = calculate_swaps(col_mismatches, n as i32);

        if row_swaps == i32::MAX || col_swaps == i32::MAX {
            return -1;
        }

        row_swaps + col_swaps
    }
}