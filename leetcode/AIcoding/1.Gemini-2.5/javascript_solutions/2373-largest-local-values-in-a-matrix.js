var largestLocal = function(grid) {
    const n = grid.length;
    const resultSize = n - 2;
    const maxLocal = Array(resultSize).fill(0).map(() => Array(resultSize).fill(0));

    for (let r = 0; r < resultSize; r++) {
        for (let c = 0; c < resultSize; c++) {
            let currentMax = 0;
            for (let i = r; i < r + 3; i++) {
                for (let j = c; j < c + 3; j++) {
                    if (grid[i][j] > currentMax) {
                        currentMax = grid[i][j];
                    }
                }
            }
            maxLocal[r][c] = currentMax;
        }
    }

    return maxLocal;
};