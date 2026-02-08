function minTimeToComplete(tasks, time) {
    let n = tasks.length;
    let dp = new Array(n + 1).fill(0);
    for (let i = 1; i <= n; i++) {
        dp[i] = Infinity;
        for (let j = 0; j < i; j++) {
            dp[i] = Math.min(dp[i], dp[j] + time * (i - j) + tasks[i - 1]);
        }
    }
    return dp[n];
}