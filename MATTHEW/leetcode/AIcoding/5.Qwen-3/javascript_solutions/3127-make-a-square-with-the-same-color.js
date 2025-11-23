function canMakeSquare(grid) {
    const n = grid.length;
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            let count = 1;
            for (let k = 1; k <= Math.min(n - i, n - j); k++) {
                if (grid[i][j] === grid[i + k - 1][j] &&
                    grid[i][j] === grid[i][j + k - 1] &&
                    grid[i][j] === grid[i + k - 1][j + k - 1]) {
                    count++;
                    if (count >= 4) return true;
                }
            }
        }
    }
    return false;
}