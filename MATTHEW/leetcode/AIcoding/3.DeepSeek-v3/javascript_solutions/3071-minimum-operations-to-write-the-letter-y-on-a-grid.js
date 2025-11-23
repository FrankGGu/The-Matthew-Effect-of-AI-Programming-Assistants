var minimumOperationsToWriteY = function(grid) {
    const n = grid.length;
    let minOps = Infinity;

    // Check all possible pairs (a, b) where a is Y value, b is non-Y value
    for (let a = 0; a < 3; a++) {
        for (let b = 0; b < 3; b++) {
            if (a === b) continue;
            let ops = 0;
            for (let i = 0; i < n; i++) {
                for (let j = 0; j < n; j++) {
                    const isYCell = (i === j && i <= Math.floor(n / 2)) || 
                                    (i + j === n - 1 && i <= Math.floor(n / 2)) || 
                                    (j === Math.floor(n / 2) && i >= Math.floor(n / 2));
                    if (isYCell) {
                        if (grid[i][j] !== a) ops++;
                    } else {
                        if (grid[i][j] !== b) ops++;
                    }
                }
            }
            if (ops < minOps) minOps = ops;
        }
    }

    return minOps;
};