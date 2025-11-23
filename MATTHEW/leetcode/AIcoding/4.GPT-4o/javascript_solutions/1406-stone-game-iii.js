var stoneGameIII = function(stoneValue) {
    const n = stoneValue.length;
    const dp = new Array(n + 1).fill(-Infinity);
    dp[n] = 0;

    for (let i = n - 1; i >= 0; i--) {
        let sum = 0;
        for (let x = 0; x < 3 && i + x < n; x++) {
            sum += stoneValue[i + x];
            dp[i] = Math.max(dp[i], sum - dp[i + x + 1]);
        }
    }

    return dp[0] > 0 ? "Alice" : dp[0] < 0 ? "Bob" : "Tie";
};