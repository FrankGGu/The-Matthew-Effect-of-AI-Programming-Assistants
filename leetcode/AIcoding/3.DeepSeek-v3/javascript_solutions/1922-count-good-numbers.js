const MOD = BigInt(1e9 + 7);

function countGoodNumbers(n) {
    const even = Math.ceil(n / 2);
    const odd = Math.floor(n / 2);

    const pow = (base, exp) => {
        let result = 1n;
        base = BigInt(base);
        while (exp > 0) {
            if (exp % 2 === 1) {
                result = (result * base) % MOD;
            }
            base = (base * base) % MOD;
            exp = Math.floor(exp / 2);
        }
        return result;
    };

    const evenCount = pow(5, even);
    const oddCount = pow(4, odd);

    return Number((evenCount * oddCount) % MOD);
}