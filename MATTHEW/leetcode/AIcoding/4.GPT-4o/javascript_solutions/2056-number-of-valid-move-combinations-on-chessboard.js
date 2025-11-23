function countCombinations(n, k) {
    const dp = Array.from({ length: n + 1 }, () => Array(n + 1).fill(0));
    dp[0][0] = 1;

    for (let i = 0; i <= n; i++) {
        for (let j = 0; j <= n; j++) {
            if (i + 1 <= n) {
                dp[i + 1][j] += dp[i][j];
            }
            if (j + 1 <= n) {
                dp[i][j + 1] += dp[i][j];
            }
            if (i + 1 <= n && j + 1 <= n) {
                dp[i + 1][j + 1] += dp[i][j];
            }
        }
    }

    let result = 0;
    for (let i = 0; i <= n; i++) {
        for (let j = 0; j <= n; j++) {
            if (i + j === k) {
                result += dp[i][j];
            }
        }
    }

    return result;
}