var minOperations = function(grid, x) {
    const m = grid.length;
    const n = grid[0].length;
    const flattened = [];

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            flattened.push(grid[i][j]);
        }
    }

    flattened.sort((a, b) => a - b);

    const firstVal = flattened[0];
    for (let i = 1; i < flattened.length; i++) {
        if (Math.abs(flattened[i] - firstVal) % x !== 0) {
            return -1;
        }
    }

    const median = flattened[Math.floor(flattened.length / 2)];
    let operations = 0;

    for (let i = 0; i < flattened.length; i++) {
        operations += Math.abs(flattened[i] - median) / x;
    }

    return operations;
};