var brokenBoardDominoes = function(board) {
    const m = board.length;
    if (m === 0) return 0;
    const n = board[0].length;
    if (n === 0) return 0;

    const MOD = 1000000007;

    // dp[col][mask] stores the number of ways to tile the board up to column 'col-1',
    // where 'mask' represents the state of column 'col-1' with respect to column 'col'.
    // A bit 'r' in 'mask' is 1 if cell (r, col-1) is covered by a horizontal domino
    // that extends into (r, col).
    // A bit 'r' in 'mask' is 0 if cell (r, col-1) is covered by a vertical domino
    // or is empty/broken.
    const dp = Array(n + 1).fill(0).map(() => Array(1 << m).fill(0));

    // Base case: Before the first column (col=0), there are no horizontal dominoes
    // extending from an imaginary column -1 into column 0. So mask is 0.
    // There is 1 way to have an empty prefix.
    dp[0][0] = 1;

    // Helper function to generate next states for column 'col'
    // This function recursively tries to fill cells in column 'col' from 'row' downwards,
    // given the 'prevMask' from 'col-1' and building 'currentMask' for 'col+1'.
    const generateNextStates = (col, row, prevMask, currentMask, ways) => {
        // Base case: All rows in the current column 'col' have been processed.
        // We can now update dp[col + 1] with the accumulated ways for 'currentMask'.
        if (row === m) {
            dp[col + 1][currentMask] = (dp[col + 1][currentMask] + ways) % MOD;
            return;
        }

        // Check if the current cell (row, col) is already covered by a horizontal domino
        // from the previous column (col-1).
        if ((prevMask >> row) & 1) {
            // If it is covered, we just move to the next row, without changing currentMask.
            generateNextStates(col, row + 1, prevMask, currentMask, ways);
            return;
        }

        // Check if the current cell (row, col) is broken.
        if (board[row][col] === 1) {
            // A broken cell cannot be covered by any domino.
            // Since it's not covered by a horizontal from left (checked above),
            // and cannot be covered by vertical or start a horizontal, we just move on.
            // No domino is placed here, so currentMask is not affected for this cell.
            generateNextStates(col, row + 1, prevMask, currentMask, ways);
            return;
        }

        // Cell (row, col) is empty and not covered from the left.
        // We have two options:

        // Option A: Place a vertical domino covering (row, col) and (row + 1, col).
        // Conditions:
        // 1. There must be a next row (row + 1 < m).
        // 2. Cell (row + 1, col) must not be covered by a horizontal domino from (row + 1, col-1).
        // 3. Cell (row + 1, col) must not be broken.
        if (row + 1 < m && !((prevMask >> (row + 1)) & 1) && board[row + 1][col] === 0) {
            // If we place a vertical domino, both (row, col) and (row+1, col) are covered.
            // We skip to row + 2. No bits are set in currentMask for these cells.
            generateNextStates(col, row + 2, prevMask, currentMask, ways);
        }

        // Option B: Place a horizontal domino covering (row, col) and (row, col + 1).
        // Conditions:
        // 1. There must be a next column (col + 1 < n).
        // 2. Cell (row, col + 1) must not be broken.
        if (col + 1 < n && board[row][col + 1] === 0) {
            // If we place a horizontal domino, cell (row, col) is covered.
            // Cell (row, col + 1) is now covered by a horizontal domino from (row, col).
            // So, we set the 'row' bit in 'currentMask' to 1.
            generateNextStates(col, row + 1, prevMask, currentMask | (1 << row), ways);
        }
    };

    // Iterate through each column
    for (let col = 0; col < n; col++) {
        // Iterate through all possible masks for the previous column (col-1)
        for (let prevMask = 0; prevMask < (1 << m); prevMask++) {
            // If there are no ways to reach this state, skip
            if (dp[col][prevMask] === 0) {
                continue;
            }
            // Generate all possible next states for column 'col'
            generateNextStates(col, 0, prevMask, 0, dp[col][prevMask]);
        }
    }

    // The final answer is the number of ways to tile the entire board (up to column n-1),
    // such that no horizontal dominoes extend beyond column n-1 into an imaginary column n.
    // This means the final mask for column n should be 0.
    return dp[n][0];
};