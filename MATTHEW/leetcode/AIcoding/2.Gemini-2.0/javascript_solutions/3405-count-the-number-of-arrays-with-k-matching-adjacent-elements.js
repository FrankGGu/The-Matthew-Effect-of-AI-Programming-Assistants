var countArrays = function(n, k, x) {
    const MOD = 10**9 + 7;
    let same = 0;
    let diff = 1;

    for (let i = 1; i < n; i++) {
        const newSame = diff;
        const newDiff = ((same * (x === 1 ? 0 : 1)) % MOD + (diff * (n - 2)) % MOD) % MOD;

        same = newSame;
        diff = newDiff;
    }

    return same;
};