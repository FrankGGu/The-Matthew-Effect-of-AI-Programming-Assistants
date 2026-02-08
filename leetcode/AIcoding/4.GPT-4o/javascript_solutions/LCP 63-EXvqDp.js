var findBall = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const results = new Array(n).fill(0).map((_, i) => i);

    for (let row = 0; row < m; row++) {
        const nextResults = new Array(n).fill(-1);
        for (let col = 0; col < n; col++) {
            if (grid[row][col] === 1 && col < n - 1 && grid[row][col + 1] === 1) {
                nextResults[col + 1] = results[col];
            } else if (grid[row][col] === -1 && col > 0 && grid[row][col - 1] === -1) {
                nextResults[col - 1] = results[col];
            }
        }
        results = nextResults;
    }

    return results.map(x => x === -1 ? -1 : x + 1);
};