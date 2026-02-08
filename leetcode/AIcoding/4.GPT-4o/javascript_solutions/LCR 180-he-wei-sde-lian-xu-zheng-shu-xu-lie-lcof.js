function combineFiles(files) {
    const n = files.length;
    const dp = new Array(n + 1).fill(0);

    for (let i = 1; i <= n; i++) {
        dp[i] = dp[i - 1] + files[i - 1];
        for (let j = 0; j < i - 1; j++) {
            dp[i] = Math.min(dp[i], dp[j] + files.slice(j, i).reduce((a, b) => a + b, 0));
        }
    }

    return dp[n];
}