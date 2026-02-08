var minFlips = function(grid) {
    const R = grid.length;
    if (R === 0) return 0;
    const C = grid[0].length;
    if (C === 0) return 0;

    let flips = 0;

    for (let r = 0; r < R; r++) {
        for (let c = 0; c < C; c++) {
            if (r * C + c < (R - 1 - r) * C + (C - 1 - c)) {
                if (grid[r][c] !== grid[R - 1 - r][C - 1 - c]) {
                    flips++;
                }
            }
        }
    }

    return flips;
};