function minimumWhiteTiles(carpet, k) {
    const n = carpet.length;
    const dp = new Array(n + 1).fill(0);

    for (let i = 1; i <= n; i++) {
        dp[i] = dp[i - 1] + (carpet[i - 1] === 'w' ? 1 : 0);
    }

    const maxCover = new Array(n + 1).fill(0);

    for (let i = 1; i <= n; i++) {
        if (i - k >= 0) {
            maxCover[i] = Math.max(maxCover[i - 1], dp[i] - dp[i - k]);
        } else {
            maxCover[i] = Math.max(maxCover[i - 1], dp[i]);
        }
    }

    return dp[n] - maxCover[n];
}