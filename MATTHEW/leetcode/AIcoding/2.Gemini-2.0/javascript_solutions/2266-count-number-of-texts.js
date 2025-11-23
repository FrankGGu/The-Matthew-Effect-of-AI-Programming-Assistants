var countTexts = function(pressedKeys) {
    const MOD = 10**9 + 7;
    const n = pressedKeys.length;
    const dp = new Array(n + 1).fill(0);
    dp[0] = 1;

    for (let i = 1; i <= n; i++) {
        dp[i] = dp[i - 1];
        if (i >= 2 && pressedKeys[i - 1] === pressedKeys[i - 2]) {
            dp[i] = (dp[i] + dp[i - 2]) % MOD;
            if (i >= 3 && pressedKeys[i - 1] === pressedKeys[i - 3]) {
                dp[i] = (dp[i] + dp[i - 3]) % MOD;
                if ((pressedKeys[i - 1] === '7' || pressedKeys[i - 1] === '9') && i >= 4 && pressedKeys[i - 1] === pressedKeys[i - 4]) {
                    dp[i] = (dp[i] + dp[i - 4]) % MOD;
                }
            }
        }
    }

    return dp[n];
};