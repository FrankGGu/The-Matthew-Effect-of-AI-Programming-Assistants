function minBoxes(bullets) {
    let n = bullets.length;
    let dp = new Array(n + 1).fill(Infinity);
    dp[0] = 0;

    for (let i = 1; i <= n; i++) {
        for (let j = 1; j <= 10; j++) {
            if (i - j >= 0) {
                dp[i] = Math.min(dp[i], dp[i - j] + 1);
            }
        }
    }
    return dp[n];
}