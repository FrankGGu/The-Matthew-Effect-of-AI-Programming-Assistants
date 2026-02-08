var minimumMoves = function(grid) {
    let zeros = [];
    let stones = [];
    for (let i = 0; i < 3; i++) {
        for (let j = 0; j < 3; j++) {
            if (grid[i][j] === 0) {
                zeros.push([i, j]);
            } else if (grid[i][j] > 1) {
                for (let k = 0; k < grid[i][j] - 1; k++) {
                    stones.push([i, j]);
                }
            }
        }
    }

    let n = zeros.length;
    let m = stones.length;
    let dp = Array(1 << n).fill(Infinity);
    dp[0] = 0;

    for (let mask = 0; mask < (1 << n); mask++) {
        if (dp[mask] === Infinity) continue;

        let count = 0;
        for (let i = 0; i < n; i++) {
            if ((mask & (1 << i)) !== 0) {
                count++;
            }
        }

        if(count >= m) continue;

        for (let i = 0; i < n; i++) {
            if ((mask & (1 << i)) === 0) {
                let cost = Math.abs(zeros[i][0] - stones[count][0]) + Math.abs(zeros[i][1] - stones[count][1]);
                dp[mask | (1 << i)] = Math.min(dp[mask | (1 << i)], dp[mask] + cost);
            }
        }
    }

    return dp[(1 << n) - 1];
};