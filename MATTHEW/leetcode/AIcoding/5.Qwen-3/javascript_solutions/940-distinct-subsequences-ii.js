function countDistinctSubsequences(s) {
    const MOD = 1000000007;
    let dp = 1;
    let last = {};
    for (let i = 0; i < s.length; i++) {
        let c = s[i];
        let prev = dp;
        if (last[c] !== undefined) {
            dp = (dp + prev - last[c]) % MOD;
        } else {
            dp = (dp + prev) % MOD;
        }
        last[c] = prev;
    }
    return dp - 1;
}