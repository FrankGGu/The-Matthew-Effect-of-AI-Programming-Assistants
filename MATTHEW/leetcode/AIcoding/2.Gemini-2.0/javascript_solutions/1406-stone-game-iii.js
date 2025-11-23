var stoneGameIII = function(stoneValue) {
    const n = stoneValue.length;
    const dp = new Array(n + 1).fill(-Infinity);
    dp[n] = 0;

    for (let i = n - 1; i >= 0; i--) {
        let sum = 0;
        for (let j = i; j < Math.min(i + 3, n); j++) {
            sum += stoneValue[j];
            dp[i] = Math.max(dp[i], sum - dp[j + 1]);
        }
    }

    if (dp[0] > 0) {
        return "Alice";
    } else if (dp[0] < 0) {
        return "Bob";
    } else {
        return "Tie";
    }
};