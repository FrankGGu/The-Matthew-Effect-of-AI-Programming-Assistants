var minFlips = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    let flips = 0;

    for (let i = 0; i < Math.floor(m / 2); i++) {
        for (let j = 0; j < n; j++) {
            const oppositeRow = m - 1 - i;
            if (grid[i][j] !== grid[oppositeRow][n - 1 - j]) {
                flips++;
            }
        }
    }

    if (m % 2 === 1) {
        const midRow = Math.floor(m / 2);
        for (let j = 0; j < Math.floor(n / 2); j++) {
            const oppositeCol = n - 1 - j;
            if (grid[midRow][j] !== grid[midRow][oppositeCol]) {
                flips++;
            }
        }
    }

    return flips;
};