var distinctSubseqII = function(s) {
    const MOD = 10**9 + 7;
    const last = new Array(26).fill(-1);
    let dp = new Array(s.length + 1).fill(0);
    dp[0] = 1;

    for (let i = 1; i <= s.length; i++) {
        dp[i] = (2 * dp[i - 1]) % MOD;
        const charCode = s.charCodeAt(i - 1) - 'a'.charCodeAt(0);
        if (last[charCode] !== -1) {
            dp[i] = (dp[i] - dp[last[charCode] - 1] + MOD) % MOD;
        }
        last[charCode] = i;
    }

    return (dp[s.length] - 1 + MOD) % MOD;
};