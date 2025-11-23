var checkSubgrid = function(grid, k) {
    const m = grid.length;
    const n = grid[0].length;
    let sum = 0;
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            sum += grid[i][j];
        }
    }

    if (sum < k) return false;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 1) {
                return true;
            }
        }
    }

    return false;
};