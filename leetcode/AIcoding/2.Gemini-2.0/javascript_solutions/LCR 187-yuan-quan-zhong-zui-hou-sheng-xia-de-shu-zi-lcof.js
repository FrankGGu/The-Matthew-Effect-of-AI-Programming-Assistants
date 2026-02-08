var iceBreakingGame = function(grid) {
    const m = grid.length;
    const n = grid[0].length;

    let ones = 0;
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 1) {
                ones++;
            }
        }
    }

    return ones % 2 === 0 ? 0 : 1;
};