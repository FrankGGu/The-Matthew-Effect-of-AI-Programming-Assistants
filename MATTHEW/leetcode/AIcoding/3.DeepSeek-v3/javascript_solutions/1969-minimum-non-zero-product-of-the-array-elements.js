var minNonZeroProduct = function(p) {
    const MOD = 1e9 + 7;
    const maxNum = (1n << BigInt(p)) - 1n;
    const half = maxNum / 2n;
    const power = (base, exp) => {
        let res = 1n;
        while (exp > 0n) {
            if (exp % 2n === 1n) {
                res = (res * base) % MOD;
            }
            base = (base * base) % MOD;
            exp = exp / 2n;
        }
        return res;
    };
    const product = power(maxNum - 1n, half);
    return (product * (maxNum % MOD)) % MOD;
};