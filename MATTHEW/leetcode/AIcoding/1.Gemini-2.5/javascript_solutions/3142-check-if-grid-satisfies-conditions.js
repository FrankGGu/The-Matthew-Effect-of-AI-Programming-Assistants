var satisfiesConditions = function(grid) {
    const m = grid.length;
    const n = grid[0].length;

    // Check Condition 1: grid[i][j] is equal to grid[i+1][j]
    // for all i from 0 to m-2 and for all j from 0 to n-1.
    for (let j = 0; j < n; j++) {
        for (let i = 0; i < m - 1; i++) {
            if (grid[i][j] !== grid[i+1][j]) {
                return false;
            }
        }
    }

    // Check Condition 2: grid[i][j] is not equal to grid[i][j+1]
    // for all i from 0 to m-1 and for all j from 0 to n-2.
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n - 1; j++) {
            if (grid[i][j] === grid[i][j+1]) {
                return false;
            }
        }
    }

    // If both conditions are satisfied
    return true;
};