var minimumOperationsToMakeEqual = function(x, y) {
    if (x >= y) {
        return x - y;
    }

    let dp = new Array(x + 1).fill(Infinity);
    dp[x] = 0;

    for (let i = x; i >= 0; i--) {
        if (i < y && dp[i] === Infinity) continue;
        if (i > 0) {
            dp[i - 1] = Math.min(dp[i - 1], dp[i] + 1);
        }
        if (i < 20000) {
            dp[i + 1] = Math.min(dp[i + 1], dp[i] + 1);
        }

        let rem5 = i % 5;
        let rem11 = i % 11;

        if (i - rem5 >= 0) {
            dp[i - rem5] = Math.min(dp[i - rem5], dp[i] + rem5 + 1);
        }
        if (i + (5 - rem5) <= 20000) {
            dp[i + (5 - rem5)] = Math.min(dp[i + (5 - rem5)], dp[i] + (5 - rem5) + 1);
        }

        if (i - rem11 >= 0) {
            dp[i - rem11] = Math.min(dp[i - rem11], dp[i] + rem11 + 1);
        }

        if (i + (11 - rem11) <= 20000) {
            dp[i + (11 - rem11)] = Math.min(dp[i + (11 - rem11)], dp[i] + (11 - rem11) + 1);
        }
    }
    return dp[y];
};