var countGoodNumbers = function(n) {
    const MOD = 1e9 + 7;
    const evenCount = Math.ceil(n / 2);
    const oddCount = Math.floor(n / 2);
    const power = (x, y) => {
        let res = 1;
        while (y > 0) {
            if (y % 2 === 1) res = (res * x) % MOD;
            x = (x * x) % MOD;
            y = Math.floor(y / 2);
        }
        return res;
    };
    return (power(5, oddCount) * power(4, evenCount)) % MOD;
};