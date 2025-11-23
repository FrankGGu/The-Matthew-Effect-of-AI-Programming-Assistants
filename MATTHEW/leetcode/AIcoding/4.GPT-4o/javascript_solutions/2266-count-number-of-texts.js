var countTexts = function(pressedKeys) {
    const mod = 1e9 + 7;
    const dp = new Array(pressedKeys.length + 1).fill(0);
    dp[0] = 1;

    for (let i = 1; i <= pressedKeys.length; i++) {
        let count = 1;
        while (i - count >= 0 && pressedKeys[i - 1] === pressedKeys[i - count]) {
            if (pressedKeys[i - 1] === '7' || pressedKeys[i - 1] === '9') {
                if (count <= 4) dp[i] = (dp[i] + dp[i - count]) % mod;
            } else {
                if (count <= 3) dp[i] = (dp[i] + dp[i - count]) % mod;
            }
            count++;
        }
    }

    return dp[pressedKeys.length];
};