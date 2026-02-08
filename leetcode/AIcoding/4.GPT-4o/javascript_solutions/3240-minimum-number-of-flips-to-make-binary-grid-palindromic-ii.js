var minFlips = function(grid) {
    const m = grid.length, n = grid[0].length;
    const target = new Array(m).fill(0).map(() => new Array(n).fill(0));
    let flips = 0;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            target[i][j] = grid[m - 1 - i][n - 1 - j];
        }
    }

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] !== target[i][j]) {
                flips++;
            }
        }
    }

    return Math.floor(flips / 2);
};