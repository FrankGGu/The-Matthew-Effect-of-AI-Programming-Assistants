var tribonacci = function(n) {
    if (n === 0) return 0;
    if (n === 1 || n === 2) return 1;

    let dp = [0, 1, 1];

    for (let i = 3; i <= n; i++) {
        let next = dp[0] + dp[1] + dp[2];
        dp[0] = dp[1];
        dp[1] = dp[2];
        dp[2] = next;
    }

    return dp[2];
};