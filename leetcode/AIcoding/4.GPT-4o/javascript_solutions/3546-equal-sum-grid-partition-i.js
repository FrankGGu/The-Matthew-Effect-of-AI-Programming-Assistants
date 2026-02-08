var canPartition = function(grid) {
    const row = grid.length, col = grid[0].length;
    let totalSum = 0;

    for (let i = 0; i < row; i++) {
        for (let j = 0; j < col; j++) {
            totalSum += grid[i][j];
        }
    }

    if (totalSum % 2 !== 0) return false;

    const target = totalSum / 2;
    const dp = new Set([0]);

    for (let i = 0; i < row; i++) {
        for (let j = 0; j < col; j++) {
            const num = grid[i][j];
            const newSet = new Set(dp);
            for (const sum of dp) {
                if (sum + num === target) return true;
                newSet.add(sum + num);
            }
            dp = newSet;
        }
    }

    return false;
};