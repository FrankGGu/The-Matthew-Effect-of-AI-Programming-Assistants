var transformToChessboard = function(board) {
    const n = board.length;

    // Step 1: Check if the grid can be transformed into a chessboard pattern.
    // A valid chessboard pattern has the property: board[i][j] == board[i][0] ^ board[0][j] ^ board[0][0]
    // This can be rearranged to: (board[i][j] ^ board[i][0]) == (board[0][j] ^ board[0][0])
    // If this condition is not met for any cell, it's impossible to form a chessboard.
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (((board[i][j] ^ board[i][0]) ^ (board[0][j] ^ board[0][0])) === 1) {
                return -1;
            }
        }
    }

    // Step 2: Check balance of 0s and 1s in the first row and first column.
    // For an N x N chessboard:
    // If N is even, every row and column must have N/2 zeros and N/2 ones.
    // If N is odd, every row and column must have (N-1)/2 and (N+1)/2 zeros/ones.
    // We only need to check the first row and first column for these counts,
    // as the previous check ensures all other rows/columns follow the same pattern relative to the first.

    let firstRowOnes = 0; // Count of 1s in the first row (board[0][j])
    let firstColOnes = 0; // Count of 1s in the first column (board[i][0])

    // Also, count mismatches for calculating swaps later.
    // `firstRowMismatchesTo0101` counts `j` where `board[0][j] != j % 2`.
    // `firstColMismatchesTo0101` counts `i` where `board[i][0] != i % 2`.
    let firstRowMismatchesTo0101 = 0;
    let firstColMismatchesTo0101 = 0;

    for (let i = 0; i < n; i++) {
        if (board[0][i] === 1) {
            firstRowOnes++;
        }
        if (board[i][0] === 1) {
            firstColOnes++;
        }

        if (board[0][i] !== (i % 2)) {
            firstRowMismatchesTo0101++;
        }
        if (board[i][0] !== (i % 2)) {
            firstColMismatchesTo0101++;
        }
    }

    // Check balance for firstRowOnes and firstColOnes
    if (n % 2 === 0) { // n is even
        if (firstRowOnes !== n / 2 || firstColOnes !== n / 2) {
            return -1;
        }
    } else { // n is odd
        if (firstRowOnes !== Math.floor(n / 2) && firstRowOnes !== Math.ceil(n / 2)) {
            return -1;
        }
        if (firstColOnes !== Math.floor(n / 2) && firstColOnes !== Math.ceil(n / 2)) {
            return -1;
        }
    }

    // Step 3: Calculate minimum swaps for rows and columns independently.
    // This helper calculates minimum swaps for a 1D array of first elements (e.g., board[i][0] for rows, or board[0][j] for columns).
    // `mismatches` is the count of elements that don't match the `0101...` pattern.
    // `countOfOnes` is the total count of '1's in this 1D array.
    const calculateMinSwaps = (mismatches, countOfOnes, nVal) => {
        if (nVal % 2 === 0) { // Even nVal
            // For even n, both `0101...` and `1010...` are valid target patterns.
            // `mismatches` is the count for `0101...` target. `nVal - mismatches` is for `1010...` target.
            // The number of swaps is half the number of mismatches.
            return Math.min(mismatches, nVal - mismatches) / 2;
        } else { // Odd nVal
            // For odd n, only one target pattern is valid based on the counts of 0s and 1s.
            // If `countOfOnes` is `Math.floor(nVal / 2)`, it means there are more zeros (`Math.ceil(nVal / 2)` zeros).
            // The target pattern must start with 0 (e.g., `01010`). We use `mismatches`.
            if (countOfOnes === Math.floor(nVal / 2)) {
                return mismatches / 2;
            } else { // `countOfOnes` is `Math.ceil(nVal / 2)` (more ones).
                // The target pattern must start with 1 (e.g., `10101`). We use `nVal - mismatches`.
                return (nVal - mismatches) / 2;
            }
        }
    };

    // Calculate row swaps (based on first column elements board[i][0])
    let rowSwaps = calculateMinSwaps(firstColMismatchesTo0101, firstColOnes, n);
    // Calculate column swaps (based on first row elements board[0][j])
    let colSwaps = calculateMinSwaps(firstRowMismatchesTo0101, firstRowOnes, n);

    // If any calculation resulted in a non-integer number of swaps (which happens if mismatches is odd for odd N), it's impossible.
    // However, the prior count checks should prevent this.
    if (rowSwaps % 1 !== 0 || colSwaps % 1 !== 0) {
        return -1;
    }

    return rowSwaps + colSwaps;
};