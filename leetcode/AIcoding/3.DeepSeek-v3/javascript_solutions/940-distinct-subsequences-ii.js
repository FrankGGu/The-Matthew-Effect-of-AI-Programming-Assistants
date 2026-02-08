var distinctSubseqII = function(s) {
    const MOD = 1e9 + 7;
    const dp = new Array(s.length + 1).fill(0);
    dp[0] = 1;
    const last = {};

    for (let i = 0; i < s.length; i++) {
        const char = s[i];
        dp[i + 1] = (2 * dp[i]) % MOD;
        if (char in last) {
            dp[i + 1] = (dp[i + 1] - dp[last[char]] + MOD) % MOD;
        }
        last[char] = i;
    }

    return (dp[s.length] - 1) % MOD;
};