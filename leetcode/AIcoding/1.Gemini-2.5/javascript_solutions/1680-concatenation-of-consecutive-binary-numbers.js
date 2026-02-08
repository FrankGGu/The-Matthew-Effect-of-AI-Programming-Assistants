var concatenatedBinary = function(n) {
    let res = 0;
    const MOD = 1000000007;
    let length = 0;

    for (let i = 1; i <= n; i++) {
        if ((i & (i - 1)) === 0) {
            length++;
        }

        res = (res * (1 << length)) % MOD;
        res = (res + i) % MOD;
    }

    return res;
};