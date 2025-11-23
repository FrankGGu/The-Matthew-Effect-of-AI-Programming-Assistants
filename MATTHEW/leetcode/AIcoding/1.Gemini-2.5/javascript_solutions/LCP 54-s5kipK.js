var solve = function(strongholds, k) {
    const dp = new Array(k + 1).fill(0);

    for (const [defense, reward] of strongholds) {
        for (let j = k; j >= defense; j--) {
            dp[j] = Math.max(dp[j], dp[j - defense] + reward);
        }
    }

    return dp[k];
};