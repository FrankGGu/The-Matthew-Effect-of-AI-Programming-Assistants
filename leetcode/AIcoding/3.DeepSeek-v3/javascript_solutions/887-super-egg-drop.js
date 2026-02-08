var superEggDrop = function(K, N) {
    let dp = Array(K + 1).fill(0).map(() => Array(N + 1).fill(0));
    let m = 0;
    while (dp[K][m] < N) {
        m++;
        for (let k = 1; k <= K; k++) {
            dp[k][m] = dp[k][m - 1] + dp[k - 1][m - 1] + 1;
        }
    }
    return m;
};