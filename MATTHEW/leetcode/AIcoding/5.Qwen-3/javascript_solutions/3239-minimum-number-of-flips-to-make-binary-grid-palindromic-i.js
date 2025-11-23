function minFlips(grid) {
    const n = grid.length;
    const m = grid[0].length;
    let flips = 0;

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < m / 2; j++) {
            const left = grid[i][j];
            const right = grid[i][m - 1 - j];
            if (left !== right) {
                flips++;
            }
        }
    }

    return flips;
}