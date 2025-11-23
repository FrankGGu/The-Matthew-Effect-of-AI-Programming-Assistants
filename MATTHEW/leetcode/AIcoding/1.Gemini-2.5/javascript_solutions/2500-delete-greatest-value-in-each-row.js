var deleteGreatestValue = function(grid) {
    const m = grid.length;
    const n = grid[0].length;

    for (let i = 0; i < m; i++) {
        grid[i].sort((a, b) => a - b);
    }

    let totalSum = 0;

    for (let j = n - 1; j >= 0; j--) {
        let maxInCurrentCollection = 0;
        for (let i = 0; i < m; i++) {
            maxInCurrentCollection = Math.max(maxInCurrentCollection, grid[i][j]);
        }
        totalSum += maxInCurrentCollection;
    }

    return totalSum;
};