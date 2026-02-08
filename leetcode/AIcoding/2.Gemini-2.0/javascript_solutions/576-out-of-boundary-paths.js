var findPaths = function(m, n, maxMove, startRow, startColumn) {
    const MOD = 10**9 + 7;
    let dp = Array(m).fill(null).map(() => Array(n).fill(0));
    dp[startRow][startColumn] = 1;
    let count = 0;

    for (let move = 1; move <= maxMove; move++) {
        let temp = Array(m).fill(null).map(() => Array(n).fill(0));
        for (let i = 0; i < m; i++) {
            for (let j = 0; j < n; j++) {
                if (dp[i][j] > 0) {
                    if (i > 0) {
                        temp[i - 1][j] = (temp[i - 1][j] + dp[i][j]) % MOD;
                    } else {
                        count = (count + dp[i][j]) % MOD;
                    }
                    if (i < m - 1) {
                        temp[i + 1][j] = (temp[i + 1][j] + dp[i][j]) % MOD;
                    } else {
                        count = (count + dp[i][j]) % MOD;
                    }
                    if (j > 0) {
                        temp[i][j - 1] = (temp[i][j - 1] + dp[i][j]) % MOD;
                    } else {
                        count = (count + dp[i][j]) % MOD;
                    }
                    if (j < n - 1) {
                        temp[i][j + 1] = (temp[i][j + 1] + dp[i][j]) % MOD;
                    } else {
                        count = (count + dp[i][j]) % MOD;
                    }
                }
            }
        }
        dp = temp;
    }

    return count;
};