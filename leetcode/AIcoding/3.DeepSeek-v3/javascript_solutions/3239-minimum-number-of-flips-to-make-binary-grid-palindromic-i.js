var minFlips = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    let flips = 0;

    for (let i = 0; i < Math.floor(m / 2); i++) {
        for (let j = 0; j < Math.floor(n / 2); j++) {
            const topLeft = grid[i][j];
            const topRight = grid[i][n - 1 - j];
            const bottomLeft = grid[m - 1 - i][j];
            const bottomRight = grid[m - 1 - i][n - 1 - j];

            const sum = topLeft + topRight + bottomLeft + bottomRight;
            flips += Math.min(sum, 4 - sum);
        }
    }

    if (m % 2 === 1) {
        const midRow = Math.floor(m / 2);
        for (let j = 0; j < Math.floor(n / 2); j++) {
            const left = grid[midRow][j];
            const right = grid[midRow][n - 1 - j];
            if (left !== right) {
                flips++;
            }
        }
    }

    if (n % 2 === 1) {
        const midCol = Math.floor(n / 2);
        for (let i = 0; i < Math.floor(m / 2); i++) {
            const top = grid[i][midCol];
            const bottom = grid[m - 1 - i][midCol];
            if (top !== bottom) {
                flips++;
            }
        }
    }

    return flips;
};