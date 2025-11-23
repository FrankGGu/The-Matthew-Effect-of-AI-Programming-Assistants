function orderOfLargestPlusSign(n) {
    const dp = Array(n).fill(0).map(() => Array(n).fill(1));
    const max = Array(n).fill(0).map(() => Array(n).fill(1));

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (j > 0) dp[i][j] = dp[i][j - 1] + 1;
            if (i > 0) dp[i][j] = Math.min(dp[i][j], dp[i - 1][j] + 1);
        }
    }

    for (let i = n - 1; i >= 0; i--) {
        for (let j = n - 1; j >= 0; j--) {
            if (j < n - 1) dp[i][j] = Math.min(dp[i][j], dp[i][j + 1] + 1);
            if (i < n - 1) dp[i][j] = Math.min(dp[i][j], dp[i + 1][j] + 1);
            max[i][j] = dp[i][j];
        }
    }

    let result = 0;
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            result = Math.max(result, max[i][j]);
        }
    }

    return result;
}