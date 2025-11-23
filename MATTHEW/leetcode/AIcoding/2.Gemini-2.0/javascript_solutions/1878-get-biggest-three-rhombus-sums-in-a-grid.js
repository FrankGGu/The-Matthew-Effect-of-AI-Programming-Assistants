var getBiggestThree = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const sums = new Set();

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            sums.add(grid[i][j]);
            for (let k = 1; i - k >= 0 && i + k < m && j - k >= 0 && j + k < n; k++) {
                let sum = 0;
                for (let l = 0; l < k; l++) {
                    sum += grid[i - k + l][j + k - l];
                    sum += grid[i - k + l][j - k + l];
                    sum += grid[i + k - l][j + k - l];
                    sum += grid[i + k - l][j - k + l];
                }
                sum += grid[i - k][j];
                sum += grid[i + k][j];
                sum += grid[i][j - k];
                sum += grid[i][j + k];
                sums.add(sum);
            }
        }
    }

    const sortedSums = Array.from(sums).sort((a, b) => b - a);
    return sortedSums.slice(0, Math.min(3, sortedSums.length));
};