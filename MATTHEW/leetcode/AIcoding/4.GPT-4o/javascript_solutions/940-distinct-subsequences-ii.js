var distinctSubseqII = function(s) {
    const MOD = 1e9 + 7;
    const dp = new Array(s.length + 1).fill(0);
    const last = new Map();

    dp[0] = 1; // empty subsequence

    for (let i = 1; i <= s.length; i++) {
        dp[i] = (2 * dp[i - 1]) % MOD;
        if (last.has(s[i - 1])) {
            dp[i] = (dp[i] - dp[last.get(s[i - 1]) - 1] + MOD) % MOD;
        }
        last.set(s[i - 1], i);
    }

    return (dp[s.length] - 1 + MOD) % MOD;
};