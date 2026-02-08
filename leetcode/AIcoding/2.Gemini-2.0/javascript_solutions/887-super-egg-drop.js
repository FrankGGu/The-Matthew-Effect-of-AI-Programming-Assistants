var superEggDrop = function(k, n) {
    let dp = Array(k + 1).fill(null).map(() => Array(n + 1).fill(0));
    let m = 0;
    while (dp[k][m] < n) {
        m++;
        for (let i = 1; i <= k; i++) {
            dp[i][m] = dp[i - 1][m - 1] + dp[i][m - 1] + 1;
        }
    }
    return m;
};