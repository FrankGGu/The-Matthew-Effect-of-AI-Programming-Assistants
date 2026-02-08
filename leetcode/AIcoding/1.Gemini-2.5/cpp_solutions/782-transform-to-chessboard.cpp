#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int calculate_swaps(const std::vector<int>& first_elements, int n) {
        int mismatches_to_start_with_0 = 0;
        int count_zeros = 0;

        for (int i = 0; i < n; ++i) {
            if (first_elements[i] == 0) {
                count_zeros++;
            }
            if (first_elements[i] != (i % 2)) { // Target pattern: 0, 1, 0, 1...
                mismatches_to_start_with_0++;
            }
        }

        int count_ones = n - count_zeros;

        if (n % 2 == 0) { // n is even
            if (count_zeros != n / 2 || count_ones != n / 2) {
                return -1; // Number of 0s and 1s must be equal
            }
            // For even n, both target patterns (0,1,0,1... and 1,0,1,0...) are valid.
            // The number of mismatches (and thus swaps) will always be even if counts are balanced.
            // We choose the pattern that requires fewer mismatches.
            return std::min(mismatches_to_start_with_0, n - mismatches_to_start_with_0) / 2;
        } else { // n is odd
            // For odd n, one pattern requires (n+1)/2 of one value and (n-1)/2 of the other.
            // The other pattern reverses these counts.
            if (count_zeros == (n + 1) / 2 && count_ones == (n - 1) / 2) { // Target pattern: 0, 1, 0, 1...
                // The number of mismatches (and thus swaps) will always be even if counts are balanced.
                return mismatches_to_start_with_0 / 2;
            } else if (count_ones == (n + 1) / 2 && count_zeros == (n - 1) / 2) { // Target pattern: 1, 0, 1, 0...
                // The number of mismatches (and thus swaps) will always be even if counts are balanced.
                return (n - mismatches_to_start_with_0) / 2;
            } else {
                return -1; // Invalid counts for odd n
            }
        }
    }

    int movesToChessboard(std::vector<std::vector<int>>& board) {
        int n = board.size();

        // 1. Check consistency of patterns
        // A valid chessboard requires that for any 2x2 subgrid, the elements must form a checkerboard pattern.
        // This means board[i][j] ^ board[i+1][j] ^ board[i][j+1] ^ board[i+1][j+1] must be 0.
        // This condition simplifies to: (board[i][j] ^ board[i][0]) == (board[0][j] ^ board[0][0])
        // for all i, j > 0.
        // This ensures that every row is either identical to row[0] or its bitwise complement,
        // and similarly for columns.
        for (int i = 1; i < n; ++i) {
            for (int j = 1; j < n; ++j) {
                if ((board[i][j] ^ board[i][0]) != (board[0][j] ^ board[0][0])) {
                    return -1;
                }
            }
        }

        // 2. Extract first row and first column for swap calculation
        // The first_row_elements represent the values in board[0][j] for j=0 to n-1.
        // These values determine the patterns of columns.
        std::vector<int> first_row_elements(n);
        // The first_col_elements represent the values in board[i][0] for i=0 to n-1.
        // These values determine the patterns of rows.
        std::vector<int> first_col_elements(n);
        for (int i = 0; i < n; ++i) {
            first_row_elements[i] = board[0][i];
            first_col_elements[i] = board[i][0];
        }

        // 3. Calculate minimum row swaps
        int row_swaps = calculate_swaps(first_col_elements, n);
        if (row_swaps == -1) {
            return -1;
        }

        // 4. Calculate minimum column swaps
        int col_swaps = calculate_swaps(first_row_elements, n);
        if (col_swaps == -1) {
            return -1;
        }

        // 5. Return total minimum swaps
        return row_swaps + col_swaps;
    }
};