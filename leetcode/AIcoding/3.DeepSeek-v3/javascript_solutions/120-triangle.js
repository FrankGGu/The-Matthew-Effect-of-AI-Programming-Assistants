var minimumTotal = function(triangle) {
    const n = triangle.length;
    const dp = new Array(n);
    for (let i = 0; i < n; i++) {
        dp[i] = new Array(triangle[i].length);
    }
    dp[0][0] = triangle[0][0];
    for (let i = 1; i < n; i++) {
        for (let j = 0; j <= i; j++) {
            if (j === 0) {
                dp[i][j] = dp[i-1][j] + triangle[i][j];
            } else if (j === i) {
                dp[i][j] = dp[i-1][j-1] + triangle[i][j];
            } else {
                dp[i][j] = Math.min(dp[i-1][j-1], dp[i-1][j]) + triangle[i][j];
            }
        }
    }
    return Math.min(...dp[n-1]);
};