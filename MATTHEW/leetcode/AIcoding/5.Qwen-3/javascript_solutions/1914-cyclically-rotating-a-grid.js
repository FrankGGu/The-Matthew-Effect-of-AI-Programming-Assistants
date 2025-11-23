function rotateGrid(grid, k) {
    const m = grid.length;
    const n = grid[0].length;
    const result = grid.map(row => [...row]);

    const totalElements = m * n;
    const rotations = k % totalElements;

    for (let i = 0; i < rotations; i++) {
        const temp = result[m - 1][n - 1];
        for (let r = m - 1; r >= 0; r--) {
            for (let c = n - 1; c >= 0; c--) {
                if (r === m - 1 && c === n - 1) continue;
                if (r === m - 1) {
                    result[r][c] = result[r][c - 1];
                } else if (c === 0) {
                    result[r][c] = result[r + 1][c];
                } else {
                    result[r][c] = result[r][c - 1];
                }
            }
        }
        result[0][0] = temp;
    }

    return result;
}