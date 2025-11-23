function findMissingAndRepeatedValues(grid) {
    const n = grid.length;
    const seen = new Set();
    let repeated = -1;
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            const num = grid[i][j];
            if (seen.has(num)) {
                repeated = num;
            } else {
                seen.add(num);
            }
        }
    }
    for (let i = 1; i <= n * n; i++) {
        if (!seen.has(i)) {
            return [i, repeated];
        }
    }
    return [-1, repeated];
}