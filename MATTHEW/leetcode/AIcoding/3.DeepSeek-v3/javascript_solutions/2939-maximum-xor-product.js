var maximumXorProduct = function(a, b, n) {
    const MOD = 1e9 + 7;
    let x = 0;
    for (let i = n - 1; i >= 0; --i) {
        let mask = 1 << i;
        let aBit = (a & mask) ? 1 : 0;
        let bBit = (b & mask) ? 1 : 0;
        if (aBit === bBit) {
            x |= mask;
        } else {
            if (a < b) {
                let temp = a;
                a = b;
                b = temp;
            }
            if ((a ^ x) > (b ^ x)) {
                x |= mask;
            }
        }
    }
    return ((a ^ x) % MOD) * ((b ^ x) % MOD) % MOD;
};