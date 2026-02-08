var matrixScore = function(grid) {
    const m = grid.length;
    const n = grid[0].length;

    for (let i = 0; i < m; i++) {
        if (grid[i][0] === 0) {
            for (let j = 0; j < n; j++) {
                grid[i][j] = 1 - grid[i][j];
            }
        }
    }

    for (let j = 1; j < n; j++) {
        let count = 0;
        for (let i = 0; i < m; i++) {
            if (grid[i][j] === 1) {
                count++;
            }
        }
        if (count < m - count) {
            for (let i = 0; i < m; i++) {
                grid[i][j] = 1 - grid[i][j];
            }
        }
    }

    let score = 0;
    for (let i = 0; i < m; i++) {
        let row = 0;
        for (let j = 0; j < n; j++) {
            row = row * 2 + grid[i][j];
        }
        score += row;
    }

    return score;
};