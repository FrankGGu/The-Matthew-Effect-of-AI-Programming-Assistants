var leastOpsExpressTarget = function(x, target) {
    if (target === 0) return 0;
    let dp = Array(target + 1).fill(Infinity);
    dp[0] = 0;

    for (let i = 1; i <= target; i++) {
        for (let j = 1; Math.pow(x, j) <= i; j++) {
            let power = Math.pow(x, j);
            dp[i] = Math.min(dp[i], dp[i - power] + j);
            if (i >= power) {
                dp[i] = Math.min(dp[i], dp[i - power] + j);
            }
        }
    }

    return dp[target];
};