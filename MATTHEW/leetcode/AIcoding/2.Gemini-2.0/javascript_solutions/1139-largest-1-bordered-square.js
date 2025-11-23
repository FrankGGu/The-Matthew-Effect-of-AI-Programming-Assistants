var largest1BorderedSquare = function(grid) {
    const n = grid.length;
    const m = grid[0].length;
    const row = Array(n).fill(null).map(() => Array(m).fill(0));
    const col = Array(n).fill(null).map(() => Array(m).fill(0));

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < m; j++) {
            if (grid[i][j] === 1) {
                row[i][j] = (j > 0 ? row[i][j - 1] : 0) + 1;
                col[i][j] = (i > 0 ? col[i - 1][j] : 0) + 1;
            }
        }
    }

    let maxSide = 0;
    for (let i = n - 1; i >= 0; i--) {
        for (let j = m - 1; j >= 0; j--) {
            let side = Math.min(row[i][j], col[i][j]);
            while (side > maxSide) {
                if (row[i - side + 1][j] >= side && col[i][j - side + 1] >= side) {
                    maxSide = side;
                    break;
                }
                side--;
            }
        }
    }

    return maxSide * maxSide;
};