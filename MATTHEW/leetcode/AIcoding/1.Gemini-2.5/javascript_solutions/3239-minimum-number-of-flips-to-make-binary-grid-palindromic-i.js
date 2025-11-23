var minimumFlips = function(grid) {
    const rows = grid.length;
    const cols = grid[0].length;
    let flips = 0;

    for (let r = 0; r < rows; r++) {
        for (let c = 0; c < cols; c++) {
            const symR = rows - 1 - r;
            const symC = cols - 1 - c;

            if (r < symR || (r === symR && c < symC)) {
                if (grid[r][c] !== grid[symR][symC]) {
                    flips++;
                }
            }
        }
    }

    return flips;
};