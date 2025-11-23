var countGoodNumbers = function(n) {
    const MOD = 10**9 + 7;

    const power = (base, exp) => {
        let res = 1;
        base %= MOD;
        while (exp > 0) {
            if (exp % 2 === 1) res = (res * base) % MOD;
            base = (base * base) % MOD;
            exp = Math.floor(exp / 2);
        }
        return res;
    };

    let evenPositions = Math.floor((n + 1) / 2);
    let oddPositions = Math.floor(n / 2);

    return (power(5, evenPositions) * power(4, oddPositions)) % MOD;
};