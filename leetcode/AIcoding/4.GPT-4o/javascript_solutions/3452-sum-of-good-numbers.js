var sumOfGoodNumbers = function(n) {
    const MOD = 1e9 + 7;
    const power = (base, exp) => {
        let result = 1;
        while (exp > 0) {
            if (exp % 2 === 1) {
                result = (result * base) % MOD;
            }
            base = (base * base) % MOD;
            exp = Math.floor(exp / 2);
        }
        return result;
    };

    return (power(5, Math.floor((n + 1) / 2)) * power(4, Math.floor(n / 2))) % MOD;
};