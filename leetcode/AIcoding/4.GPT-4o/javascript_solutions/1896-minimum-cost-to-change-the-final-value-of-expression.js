var minCost = function(startValue, desiredValue, types) {
    let diff = desiredValue - startValue;
    let dp = new Array(diff + 1).fill(Infinity);
    dp[0] = 0;

    for (const [x, y] of types) {
        for (let j = diff; j >= x; j--) {
            dp[j] = Math.min(dp[j], dp[j - x] + y);
        }
    }

    return dp[diff] === Infinity ? -1 : dp[diff];
};