var concatenatedBinary = function(n) {
    const MOD = 1e9 + 7;
    let result = 0;
    let shift = 0;

    for (let i = 1; i <= n; i++) {
        if ((i & (i - 1)) === 0) {
            shift++;
        }
        result = (result * (1 << shift) + i) % MOD;
    }

    return result;
};