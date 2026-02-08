var countCells = function(grid) {
    const R = grid.length;
    const C = grid[0].length;

    if (R === 0 || C === 0) {
        return 0;
    }

    const is_horizontal = Array(R).fill(0).map(() => Array(C).fill(false));
    const is_vertical = Array(R).fill(0).map(() => Array(C).fill(false));

    for (let r = 0; r < R; r++) {
        for (let c = 0; c < C - 1; c++) {
            if (grid[r][c] === grid[r][c+1]) {
                is_horizontal[r][c] = true;
                is_horizontal[r][c+1] = true;
            }
        }
    }

    for (let c = 0; c < C; c++) {
        for (let r = 0; r < R - 1; r++) {
            if (grid[r][c] === grid[r+1][c]) {
                is_vertical[r][c] = true;
                is_vertical[r+1][c] = true;
            }
        }
    }

    let count = 0;
    for (let r = 0; r < R; r++) {
        for (let c = 0; c < C; c++) {
            if (is_horizontal[r][c] && is_vertical[r][c]) {
                count++;
            }
        }
    }

    return count;
};