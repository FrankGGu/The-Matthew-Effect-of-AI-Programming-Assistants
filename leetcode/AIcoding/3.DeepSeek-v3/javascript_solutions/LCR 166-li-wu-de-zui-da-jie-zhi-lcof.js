var jewelleryValue = function(frame) {
    if (!frame || frame.length === 0 || frame[0].length === 0) return 0;
    const m = frame.length;
    const n = frame[0].length;
    const dp = new Array(m).fill(0).map(() => new Array(n).fill(0));
    dp[0][0] = frame[0][0];
    for (let i = 1; i < m; i++) {
        dp[i][0] = dp[i - 1][0] + frame[i][0];
    }
    for (let j = 1; j < n; j++) {
        dp[0][j] = dp[0][j - 1] + frame[0][j];
    }
    for (let i = 1; i < m; i++) {
        for (let j = 1; j < n; j++) {
            dp[i][j] = Math.max(dp[i - 1][j], dp[i][j - 1]) + frame[i][j];
        }
    }
    return dp[m - 1][n - 1];
};