var canPartition = function(grid) {
    const n = grid.length, m = grid[0].length;
    const totalSum = grid.flat().reduce((a, b) => a + b, 0);
    if (totalSum % 2 !== 0) return false;

    const target = totalSum / 2;
    const dp = new Set();
    dp.add(0);

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < m; j++) {
            const num = grid[i][j];
            const newSums = [];
            for (const sum of dp) {
                const newSum = sum + num;
                if (newSum === target) return true;
                if (newSum < target) newSums.push(newSum);
            }
            for (const newSum of newSums) {
                dp.add(newSum);
            }
        }
    }

    return false;
};