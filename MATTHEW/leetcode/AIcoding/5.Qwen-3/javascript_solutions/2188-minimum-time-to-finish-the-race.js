function minTimeToFinish(racers) {
    const n = racers.length;
    const dp = new Array(n).fill(0).map(() => new Array(2).fill(Infinity));
    dp[0][0] = racers[0][0];
    dp[0][1] = racers[0][1];

    for (let i = 1; i < n; i++) {
        dp[i][0] = Math.min(dp[i - 1][0], dp[i - 1][1]) + racers[i][0];
        dp[i][1] = Math.min(dp[i - 1][0], dp[i - 1][1]) + racers[i][1];
    }

    return Math.min(dp[n - 1][0], dp[n - 1][1]);
}