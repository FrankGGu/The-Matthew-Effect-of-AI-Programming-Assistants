var numWays = function(s) {
    const MOD = 1e9 + 7;
    const n = s.length;
    let ones = 0;
    for (const c of s) {
        if (c === '1') ones++;
    }
    if (ones % 3 !== 0) return 0;
    if (ones === 0) {
        return ((n - 1) * (n - 2) / 2) % MOD;
    }
    const target = ones / 3;
    let count = 0, ways1 = 0, ways2 = 0;
    for (const c of s) {
        if (c === '1') count++;
        if (count === target) ways1++;
        else if (count === 2 * target) ways2++;
    }
    return (ways1 * ways2) % MOD;
};