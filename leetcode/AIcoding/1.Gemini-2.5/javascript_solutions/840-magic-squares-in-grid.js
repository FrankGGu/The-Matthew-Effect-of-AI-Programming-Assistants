var numMagicSquaresInside = function(grid) {
    const R = grid.length;
    if (R < 3) {
        return 0;
    }
    const C = grid[0].length;
    if (C < 3) {
        return 0;
    }

    let count = 0;

    function isMagic(r, c) {
        // Optimization: The center element of a 3x3 magic square (1-9) must be 5.
        if (grid[r + 1][c + 1] !== 5) {
            return false;
        }

        const n0 = grid[r][c];
        const n1 = grid[r][c + 1];
        const n2 = grid[r][c + 2];
        const n3 = grid[r + 1][c];
        const n4 = grid[r + 1][c + 1]; // This is 5, already checked
        const n5 = grid[r + 1][c + 2];
        const n6 = grid[r + 2][c];
        const n7 = grid[r + 2][c + 1];
        const n8 = grid[r + 2][c + 2];

        const nums = [n0, n1, n2, n3, n4, n5, n6, n7, n8];

        // Check if all numbers are distinct and between 1 and 9
        const seen = new Set();
        for (const num of nums) {
            if (num < 1 || num > 9 || seen.has(num)) {
                return false;
            }
            seen.add(num);
        }
        // After the loop, if we haven't returned false, all 9 numbers are distinct and between 1 and 9.

        // Check sums (all must be 15 for a 1-9 magic square)
        if (n0 + n1 + n2 !== 15) return false; // Row 0
        if (n3 + n4 + n5 !== 15) return false; // Row 1
        if (n6 + n7 + n8 !== 15) return false; // Row 2

        if (n0 + n3 + n6 !== 15) return false; // Column 0
        if (n1 + n4 + n7 !== 15) return false; // Column 1
        if (n2 + n5 + n8 !== 15) return false; // Column 2

        if (n0 + n4 + n8 !== 15) return false; // Main Diagonal
        if (n2 + n4 + n6 !== 15) return false; // Anti-Diagonal

        return true;
    }

    for (let r = 0; r <= R - 3; r++) {
        for (let c = 0; c <= C - 3; c++) {
            if (isMagic(r, c)) {
                count++;
            }
        }
    }

    return count;
};