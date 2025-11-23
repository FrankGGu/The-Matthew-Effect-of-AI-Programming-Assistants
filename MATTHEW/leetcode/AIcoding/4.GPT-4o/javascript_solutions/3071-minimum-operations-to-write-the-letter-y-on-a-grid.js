function minimumOperations(grid) {
    const m = grid.length, n = grid[0].length;
    let minOps = Infinity;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            let ops = 0;
            for (let r = 0; r < m; r++) {
                for (let c = 0; c < n; c++) {
                    if (r !== i && c !== j) {
                        ops += grid[r][c];
                    }
                }
            }
            minOps = Math.min(minOps, ops);
        }
    }

    return minOps;
}