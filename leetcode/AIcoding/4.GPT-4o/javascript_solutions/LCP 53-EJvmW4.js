function defendSpaceCity(n, enemies) {
    let dp = new Array(n + 1).fill(0);
    for (let i = 1; i <= n; i++) {
        dp[i] = dp[i - 1];
        for (let j = 0; j < enemies.length; j++) {
            if (enemies[j][0] <= i) {
                dp[i] = Math.max(dp[i], dp[i - enemies[j][0]] + enemies[j][1]);
            }
        }
    }
    return dp[n];
}