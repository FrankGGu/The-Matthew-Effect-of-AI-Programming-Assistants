var hasValidPath = function(grid) {
    const m = grid.length;
    const n = grid[0].length;

    const pathLength = m + n - 1;

    // A valid parentheses string must have an even length to have a final balance of 0.
    // The path length is (m-1 - 0 + 1) + (n-1 - 0 + 1) - 1 = m + n - 1.
    if (pathLength % 2 !== 0) {
        return false;
    }

    // The path must start with '(' and end with ')' for a valid parentheses string.
    if (grid[0][0] === ')') {
        return false;
    }
    if (grid[m - 1][n - 1] === '(') {
        return false;
    }

    // dp[r][c] will be a Set of all possible valid balances encountered when reaching cell (r, c).
    // A balance is defined as (count of '(' - count of ')').
    // We only store non-negative balances.
    const dp = Array(m).fill(0).map(() => Array(n).fill(0).map(() => new Set()));

    // Initialize the starting cell (0, 0).
    // Since grid[0][0] must be '(', the initial balance is 1.
    dp[0][0].add(1);

    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            // Skip the starting cell as it's already initialized.
            if (r === 0 && c === 0) {
                continue;
            }

            const currentChar = grid[r][c];
            const currentPathLen = r + c + 1; // The number of characters in the path from (0,0) to (r,c).

            // Consider paths coming from the cell above (r-1, c).
            if (r > 0) {
                for (const prevBalance of dp[r - 1][c]) {
                    let newBalance;
                    if (currentChar === '(') {
                        newBalance = prevBalance + 1;
                    } else { // currentChar === ')'
                        newBalance = prevBalance - 1;
                    }

                    // A new balance is valid if:
                    // 1. It's non-negative (number of '(' must be greater than or equal to number of ')' in any prefix).
                    // 2. It does not exceed the current path length (e.g., "(((" has balance 3, length 3).
                    //    This also implicitly handles the parity check: if prevBalance has same parity as (r-1+c+1),
                    //    then newBalance will have same parity as (r+c+1).
                    if (newBalance >= 0 && newBalance <= currentPathLen) {
                        dp[r][c].add(newBalance);
                    }
                }
            }

            // Consider paths coming from the cell to the left (r, c-1).
            if (c > 0) {
                for (const prevBalance of dp[r][c - 1]) {
                    let newBalance;
                    if (currentChar === '(') {
                        newBalance = prevBalance + 1;
                    } else { // currentChar === ')'
                        newBalance = prevBalance - 1;
                    }

                    // Apply the same validity checks.
                    if (newBalance >= 0 && newBalance <= currentPathLen) {
                        dp[r][c].add(newBalance);
                    }
                }
            }
        }
    }

    // The path is valid if we can reach the bottom-right cell (m-1, n-1)
    // and one of the possible balances at that cell is 0.
    return dp[m - 1][n - 1].has(0);
};