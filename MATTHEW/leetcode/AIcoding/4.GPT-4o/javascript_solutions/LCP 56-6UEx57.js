var canTransmit = function(letters) {
    const n = letters.length;
    const dp = Array(n).fill(false);
    dp[0] = true;

    for (let i = 1; i < n; i++) {
        if (dp[i - 1] && letters[i] === letters[i - 1]) {
            dp[i] = true;
        }
        if (i > 1 && dp[i - 2] && letters[i] === letters[i - 2]) {
            dp[i] = true;
        }
    }

    return dp[n - 1];
};