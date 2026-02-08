var getBiggestThree = function(grid) {
    const m = grid.length, n = grid[0].length;
    const sums = new Set();

    const getRhombusSum = (x, y, d) => {
        let sum = grid[x][y];
        for (let i = 1; i <= d; i++) {
            sum += grid[x + i][y - i] || 0;
            sum += grid[x + i][y + i] || 0;
            sum += grid[x - i][y - i] || 0;
            sum += grid[x - i][y + i] || 0;
        }
        return sum;
    };

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            for (let d = 0; d < Math.min(m, n); d++) {
                if (i + d < m && i - d >= 0 && j + d < n && j - d >= 0) {
                    sums.add(getRhombusSum(i, j, d));
                } else {
                    break;
                }
            }
        }
    }

    const result = Array.from(sums).sort((a, b) => b - a).slice(0, 3);

    return result;
};