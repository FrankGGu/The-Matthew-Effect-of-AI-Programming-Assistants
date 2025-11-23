var maxTrailingZeros = function(grid) {
    const m = grid.length, n = grid[0].length;

    const countFactors = (num, factor) => {
        let count = 0;
        while (num > 0 && num % factor === 0) {
            count++;
            num /= factor;
        }
        return count;
    };

    const countZeros = (x, y) => {
        let count2 = 0, count5 = 0;
        for (let i = 0; i <= x; i++) {
            for (let j = 0; j <= y; j++) {
                count2 += countFactors(grid[i][j], 2);
                count5 += countFactors(grid[i][j], 5);
            }
        }
        return Math.min(count2, count5);
    };

    let maxZeros = 0;
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            maxZeros = Math.max(maxZeros, countZeros(i, j));
        }
    }

    return maxZeros;
};