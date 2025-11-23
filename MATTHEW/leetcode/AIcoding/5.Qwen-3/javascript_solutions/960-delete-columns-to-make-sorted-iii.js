function minDeletionSize(strs) {
    const n = strs.length;
    const m = strs[0].length;
    const dp = new Array(n).fill(1);

    for (let j = 0; j < m; j++) {
        for (let i = 1; i < n; i++) {
            if (strs[i][j] >= strs[i-1][j]) {
                dp[i] = Math.max(dp[i], dp[i-1] + 1);
            }
        }
    }

    return n - Math.max(...dp);
}