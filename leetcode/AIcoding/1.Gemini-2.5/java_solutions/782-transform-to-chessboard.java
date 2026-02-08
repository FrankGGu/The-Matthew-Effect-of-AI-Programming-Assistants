class Solution {
    public int movesToChessboard(int[][] board) {
        int N = board.length;

        // Step 1: Structural check
        // For a board to be transformable into a chessboard, it must satisfy a key property:
        // For any 2x2 subgrid, the XOR sum of its four corners must be 0.
        // This means board[i][j] ^ board[0][j] ^ board[i][0] ^ board[0][0] must be 0 for all i, j.
        // This ensures that every row is either identical to row 0 or its complement,
        // and every column is either identical to column 0 or its complement.
        for (int i = 0; i < N; i++) {
            for (int j = 0; j < N; j++) {
                if ((board[0][0] ^ board[i][0] ^ board[0][j] ^ board[i][j]) != 0) {
                    return -1;
                }
            }
        }

        // Step 2: Count 1s in the first row and first column
        // For a valid chessboard, each row and column must have a balanced number of 0s and 1s.
        // If N is even, there must be N/2 zeros and N/2 ones.
        // If N is odd, there must be (N+1)/2 of one digit and (N-1)/2 of the other.
        // This is equivalent to checking if abs(N - 2 * countOfOnes) <= 1.
        int onesInRow0 = 0; // Count of 1s in board[0][...]
        int onesInCol0 = 0; // Count of 1s in board[...][0]

        for (int i = 0; i < N; i++) {
            if (board[0][i] == 1) {
                onesInRow0++;
            }
            if (board[i][0] == 1) {
                onesInCol0++;
            }
        }

        if (Math.abs(N - 2 * onesInRow0) > 1 || Math.abs(N - 2 * onesInCol0) > 1) {
            return -1;
        }

        // Step 3: Calculate minimum swaps for rows and columns independently
        // We need to transform the first column (board[...][0]) to an alternating pattern (0101... or 1010...)
        // and similarly for the first row (board[0][...]).
        // The total swaps will be the sum of row swaps and column swaps.

        int rowMismatches0101 = 0; // Count of 'i' where board[i][0] != i % 2 (target 0,1,0,1...)
        int colMismatches0101 = 0; // Count of 'j' where board[0][j] != j % 2 (target 0,1,0,1...)

        for (int i = 0; i < N; i++) {
            if (board[i][0] != i % 2) {
                rowMismatches0101++;
            }
            if (board[0][i] != i % 2) {
                colMismatches0101++;
            }
        }

        int rowSwaps = calculateSwaps(N, rowMismatches0101);
        int colSwaps = calculateSwaps(N, colMismatches0101);

        if (rowSwaps == -1 || colSwaps == -1) {
            return -1;
        }

        return rowSwaps + colSwaps;
    }

    // Helper function to calculate minimum swaps for a single dimension (row or column)
    // N: dimension size
    // mismatches0101: count of elements that don't match the 0,1,0,1... pattern
    private int calculateSwaps(int N, int mismatches0101) {
        int mismatches1010 = N - mismatches0101; // Count of elements that don't match the 1,0,1,0... pattern

        if (N % 2 == 0) { // N is even
            // For even N, both target patterns (0101... and 1010...) require N/2 of each digit.
            // The number of elements in the wrong position must be even to be fixable by swaps.
            // If mismatches0101 is odd, it means it's impossible to form a 0101... pattern.
            // Since N is even, if mismatches0101 is odd, then mismatches1010 (N - mismatches0101) is also odd.
            // So, if mismatches0101 is odd, it's impossible to form any alternating pattern.
            if (mismatches0101 % 2 != 0) {
                return -1;
            }
            // We can choose either target pattern. The number of swaps is half the number of mismatches.
            // We take the minimum of the two options.
            return Math.min(mismatches0101, mismatches1010) / 2;
        } else { // N is odd
            // For odd N, one target pattern requires (N+1)/2 of one digit and (N-1)/2 of the other.
            // The other target pattern requires the opposite counts.
            // Since N is odd, mismatches0101 and mismatches1010 will always have different parities
            // (one even, one odd). We must choose the target pattern that results in an even number of mismatches.
            if (mismatches0101 % 2 == 0) {
                return mismatches0101 / 2;
            } else { // mismatches1010 must be even
                return mismatches1010 / 2;
            }
        }
    }
}