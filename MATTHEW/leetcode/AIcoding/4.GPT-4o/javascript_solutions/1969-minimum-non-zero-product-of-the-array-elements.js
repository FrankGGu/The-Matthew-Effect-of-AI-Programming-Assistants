var minNonZeroProduct = function(p) {
    const mod = 1n * 10n ** 9n + 7n;
    if (p === 0) return 0;
    const maxNum = (1n << BigInt(p)) - 1n;
    const maxNumMinusOne = maxNum - 1n;
    const half = (maxNum >> 1n) % mod;
    return (maxNum * modPow(maxNumMinusOne, half, mod)) % mod;
};

const modPow = (base, exp, mod) => {
    let res = 1n;
    while (exp > 0n) {
        if (exp % 2n === 1n) {
            res = (res * base) % mod;
        }
        base = (base * base) % mod;
        exp >>= 1n;
    }
    return res;
};