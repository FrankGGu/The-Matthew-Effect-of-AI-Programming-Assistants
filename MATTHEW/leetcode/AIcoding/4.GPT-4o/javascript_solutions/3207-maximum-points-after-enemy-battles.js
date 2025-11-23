var maxPoints = function(points) {
    const n = points.length;
    const dp = new Array(n).fill(0);
    dp[0] = points[0][0];

    for (let i = 1; i < n; i++) {
        dp[i] = dp[i - 1];
        for (let j = 0; j < points[i].length; j++) {
            dp[i] = Math.max(dp[i], points[i][j] + (i > 1 ? dp[i - 2] : 0));
        }
    }

    return dp[n - 1];
};