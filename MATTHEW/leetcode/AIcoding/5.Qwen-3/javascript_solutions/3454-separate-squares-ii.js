function numSquares(n) {
    const dp = new Array(n + 1).fill(0);
    for (let i = 1; i <= n; i++) {
        let min = Infinity;
        let j = 1;
        while (j * j <= i) {
            min = Math.min(min, dp[i - j * j] + 1);
            j++;
        }
        dp[i] = min;
    }
    return dp[n];
}