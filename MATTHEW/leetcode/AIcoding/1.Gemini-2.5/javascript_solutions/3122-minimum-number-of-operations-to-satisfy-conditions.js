var minimumOperations = function(grid) {
    const m = grid.length;
    const n = grid[0].length;

    // Precompute frequencies of digits for even and odd rows in each column
    // freqEven[j][digit] stores count of 'digit' in grid[i][j] where i is even
    // freqOdd[j][digit] stores count of 'digit' in grid[i][j] where i is odd
    const freqEven = Array(n).fill(0).map(() => Array(10).fill(0));
    const freqOdd = Array(n).fill(0).map(() => Array(10).fill(0));

    for (let j = 0; j < n; j++) {
        for (let i = 0; i < m; i++) {
            if (i % 2 === 0) {
                freqEven[j][grid[i][j]]++;
            } else {
                freqOdd[j][grid[i][j]]++;
            }
        }
    }

    // Calculate number of even and odd rows
    const numEvenRows = Math.ceil(m / 2);
    const numOddRows = Math.floor(m / 2);

    // costCol[j][X][Y] = minimum operations to make column j follow pattern (X, Y)
    // where all even rows in column j become X, and all odd rows in column j become Y.
    // X must be different from Y.
    const costCol = Array(n).fill(0).map(() => Array(10).fill(0).map(() => Array(10).fill(Number.POSITIVE_INFINITY)));

    for (let j = 0; j < n; j++) {
        for (let X = 0; X <= 9; X++) {
            for (let Y = 0; Y <= 9; Y++) {
                if (X === Y) {
                    continue; // X and Y must be different for vertical condition
                }
                let currentCost = 0;
                // Cost to change even rows to X
                currentCost += (numEvenRows - freqEven[j][X]);
                // Cost to change odd rows to Y
                currentCost += (numOddRows - freqOdd[j][Y]);
                costCol[j][X][Y] = currentCost;
            }
        }
    }

    // dp[j][X][Y] = minimum operations for columns 0 to j,
    // such that column j has pattern (X, Y).
    const dp = Array(n).fill(0).map(() => Array(10).fill(0).map(() => Array(10).fill(Number.POSITIVE_INFINITY)));

    // Base case: for the first column (j = 0)
    for (let X = 0; X <= 9; X++) {
        for (let Y = 0; Y <= 9; Y++) {
            if (X === Y) {
                continue;
            }
            dp[0][X][Y] = costCol[0][X][Y];
        }
    }

    // Fill DP table for columns j from 1 to n-1
    for (let j = 1; j < n; j++) {
        for (let X = 0; X <= 9; X++) { // Current column j: even rows are X
            for (let Y = 0; Y <= 9; Y++) { // Current column j: odd rows are Y
                if (X === Y) {
                    continue; // Vertical condition for current column
                }

                let minPrevDp = Number.POSITIVE_INFINITY;
                // Find the minimum operations from the previous column (j-1)
                // such that its pattern (X_prev, Y_prev) satisfies horizontal conditions
                for (let X_prev = 0; X_prev <= 9; X_prev++) {
                    for (let Y_prev = 0; Y_prev <= 9; Y_prev++) {
                        if (X_prev === Y_prev) { // Previous column must also satisfy vertical condition
                            continue;
                        }
                        // Horizontal conditions:
                        // Even rows in col j-1 (X_prev) must be different from even rows in col j (X)
                        // Odd rows in col j-1 (Y_prev) must be different from odd rows in col j (Y)
                        if (X_prev === X || Y_prev === Y) {
                            continue;
                        }
                        minPrevDp = Math.min(minPrevDp, dp[j-1][X_prev][Y_prev]);
                    }
                }

                if (minPrevDp !== Number.POSITIVE_INFINITY) {
                    dp[j][X][Y] = costCol[j][X][Y] + minPrevDp;
                }
            }
        }
    }

    // The final answer is the minimum value in the last column's DP states
    let minOps = Number.POSITIVE_INFINITY;
    for (let X = 0; X <= 9; X++) {
        for (let Y = 0; Y <= 9; Y++) {
            if (X === Y) {
                continue;
            }
            minOps = Math.min(minOps, dp[n-1][X][Y]);
        }
    }

    return minOps;
};