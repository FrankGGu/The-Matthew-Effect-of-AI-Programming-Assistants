var sumGoodSubsequences = function(s) {
    const MOD = 10**9 + 7;
    let ones = 0;
    let ans = 0;
    for (let i = 0; i < s.length; i++) {
        if (s[i] === '1') {
            ans = (ans * 2 + 1) % MOD;
            ones++;
        } else {
            ans = (ans * 2) % MOD;
        }
    }
    return (ans + (s.includes('0') ? 0 : 0)) % MOD;
};