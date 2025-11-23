function maxStudents(grid) {
    const m = grid.length;
    const n = grid[0].length;

    const dp = new Array(m).fill(0).map(() => new Array(1 << n).fill(0));

    for (let i = 0; i < m; i++) {
        for (let mask = 0; mask < (1 << n); mask++) {
            if ((mask & (mask << 1)) !== 0) continue;
            let cnt = 0;
            for (let j = 0; j < n; j++) {
                if ((mask >> j) & 1) {
                    cnt += grid[i][j];
                }
            }
            if (i === 0) {
                dp[i][mask] = cnt;
            } else {
                for (let prevMask = 0; prevMask < (1 << n); prevMask++) {
                    if ((prevMask & mask) === 0 && (prevMask & (prevMask << 1)) === 0) {
                        dp[i][mask] = Math.max(dp[i][mask], dp[i - 1][prevMask] + cnt);
                    }
                }
            }
        }
    }

    let result = 0;
    for (let mask = 0; mask < (1 << n); mask++) {
        result = Math.max(result, dp[m - 1][mask]);
    }
    return result;
}