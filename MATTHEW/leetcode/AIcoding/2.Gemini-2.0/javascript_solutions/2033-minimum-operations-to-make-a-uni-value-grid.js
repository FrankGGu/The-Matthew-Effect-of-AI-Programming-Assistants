var minOperations = function(grid, x) {
    const m = grid.length;
    const n = grid[0].length;
    const arr = [];
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            arr.push(grid[i][j]);
        }
    }
    arr.sort((a, b) => a - b);
    const median = arr[Math.floor(arr.length / 2)];
    let operations = 0;
    for (let i = 0; i < arr.length; i++) {
        const diff = Math.abs(arr[i] - median);
        if (diff % x !== 0) {
            return -1;
        }
        operations += diff / x;
    }
    return operations;
};