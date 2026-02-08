var countFertilePyramids = function(grid) {
    const m = grid.length;
    const n = grid[0].length;

    let totalPyramids = 0;

    // dp_reg[r][c] stores the maximum height of a regular pyramid with its apex at (r, c).
    // A regular pyramid grows downwards.
    const dp_reg = Array(m).fill(0).map(() => Array(n).fill(0));

    // Calculate dp_reg
    // Iterate from bottom-up for regular pyramids
    for (let r = m - 1; r >= 0; r--) {
        for (let c = 0; c < n; c++) {
            if (grid[r][c] === 0) {
                dp_reg[r][c] = 0;
            } else {
                if (r === m - 1 || c === 0 || c === n - 1) {
                    // Base case: A single fertile cell forms a pyramid of height 1.
                    // Cells on the last row or first/last column cannot be an apex of a pyramid of height > 1.
                    dp_reg[r][c] = 1;
                } else {
                    // A pyramid with apex (r, c) and height H requires:
                    // 1. grid[r][c] == 1
                    // 2. Pyramids of height H-1 at (r+1, c-1), (r+1, c), and (r+1, c+1)
                    dp_reg[r][c] = 1 + Math.min(dp_reg[r + 1][c - 1], dp_reg[r + 1][c], dp_reg[r + 1][c + 1]);
                }
            }
        }
    }

    // dp_inv[r][c] stores the maximum height of an inverse pyramid with its apex at (r, c).
    // An inverse pyramid grows upwards.
    const dp_inv = Array(m).fill(0).map(() => Array(n).fill(0));

    // Calculate dp_inv
    // Iterate from top-down for inverse pyramids
    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            if (grid[r][c] === 0) {
                dp_inv[r][c] = 0;
            } else {
                if (r === 0 || c === 0 || c === n - 1) {
                    // Base case: A single fertile cell forms an inverse pyramid of height 1.
                    // Cells on the first row or first/last column cannot be an apex of an inverse pyramid of height > 1.
                    dp_inv[r][c] = 1;
                } else {
                    // An inverse pyramid with apex (r, c) and height H requires:
                    // 1. grid[r][c] == 1
                    // 2. Inverse pyramids of height H-1 at (r-1, c-1), (r-1, c), and (r-1, c+1)
                    dp_inv[r][c] = 1 + Math.min(dp_inv[r - 1][c - 1], dp_inv[r - 1][c], dp_inv[r - 1][c + 1]);
                }
            }
        }
    }

    // Count total pyramids of height at least 2
    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            // A pyramid of height H contains H-1 sub-pyramids of height >= 2.
            // For example, a pyramid of height 3 (H=3) contains:
            // - one pyramid of height 3 (apex at (r,c))
            // - one pyramid of height 2 (apex at (r+1,c))
            // This contributes (3-1) = 2 to the count.
            totalPyramids += Math.max(0, dp_reg[r][c] - 1);
            totalPyramids += Math.max(0, dp_inv[r][c] - 1);
        }
    }

    return totalPyramids;
};