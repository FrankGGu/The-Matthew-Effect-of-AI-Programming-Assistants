var countTexts = function(s) {
    const MOD = 10**9 + 7;
    const dp = new Array(s.length + 1).fill(0);
    dp[0] = 1;

    for (let i = 1; i <= s.length; i++) {
        if (s[i-1] >= '2' && s[i-1] <= '9') {
            dp[i] = (dp[i] + dp[i-1]) % MOD;
        }

        if (i >= 2 && s[i-2] === s[i-1]) {
            dp[i] = (dp[i] + dp[i-2]) % MOD;
        }

        if (i >= 3 && s[i-3] === s[i-2] && s[i-2] === s[i-1]) {
            dp[i] = (dp[i] + dp[i-3]) % MOD;
        }
    }

    return dp[s.length];
};