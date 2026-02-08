var countVowelPermutation = function(n) {
    const mod = 1e9 + 7;
    const dp = new Array(5).fill(1);

    for (let i = 1; i < n; i++) {
        const newDp = new Array(5).fill(0);
        newDp[0] = (dp[1] + dp[2] + dp[4]) % mod; // a
        newDp[1] = (dp[0] + dp[2]) % mod;       // e
        newDp[2] = (dp[1] + dp[3]) % mod;       // i
        newDp[3] = (dp[2]) % mod;               // o
        newDp[4] = (dp[2] + dp[3]) % mod;       // u
        dp.splice(0, 5, ...newDp);
    }

    return dp.reduce((a, b) => (a + b) % mod);
};