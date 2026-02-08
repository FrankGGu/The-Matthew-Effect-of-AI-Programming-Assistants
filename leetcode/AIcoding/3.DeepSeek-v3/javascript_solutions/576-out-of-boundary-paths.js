const findPaths = function(m, n, maxMove, startRow, startColumn) {
    const MOD = 1e9 + 7;
    const dp = new Array(m).fill().map(() => new Array(n).fill(0));
    dp[startRow][startColumn] = 1;
    let count = 0;

    const directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];

    for (let move = 1; move <= maxMove; move++) {
        const temp = new Array(m).fill().map(() => new Array(n).fill(0));
        for (let i = 0; i < m; i++) {
            for (let j = 0; j < n; j++) {
                if (dp[i][j] > 0) {
                    for (const [di, dj] of directions) {
                        const ni = i + di;
                        const nj = j + dj;
                        if (ni < 0 || ni >= m || nj < 0 || nj >= n) {
                            count = (count + dp[i][j]) % MOD;
                        } else {
                            temp[ni][nj] = (temp[ni][nj] + dp[i][j]) % MOD;
                        }
                    }
                }
            }
        }
        dp = temp;
    }

    return count;
};