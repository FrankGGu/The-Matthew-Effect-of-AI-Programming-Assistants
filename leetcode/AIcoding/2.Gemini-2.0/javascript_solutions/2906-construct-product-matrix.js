var constructProductMatrix = function(grid, k) {
    const m = grid.length;
    const n = grid[0].length;
    const result = Array(m).fill(null).map(() => Array(n).fill(0));

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            let product = 1;
            for (let r = 0; r < m; r++) {
                for (let c = 0; c < n; c++) {
                    if (r === i && c === j) continue;
                    product = (product * grid[r][c]) % k;
                }
            }
            result[i][j] = product;
        }
    }

    return result;
};