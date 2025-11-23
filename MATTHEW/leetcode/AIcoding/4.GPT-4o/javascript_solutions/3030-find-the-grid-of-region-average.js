function regionAverage(grid, row, col, k) {
    let sum = 0;
    let count = 0;
    const m = grid.length;
    const n = grid[0].length;

    for (let i = Math.max(0, row - k); i <= Math.min(m - 1, row + k); i++) {
        for (let j = Math.max(0, col - k); j <= Math.min(n - 1, col + k); j++) {
            if (Math.abs(i - row) + Math.abs(j - col) <= k) {
                sum += grid[i][j];
                count++;
            }
        }
    }

    return sum / count;
}