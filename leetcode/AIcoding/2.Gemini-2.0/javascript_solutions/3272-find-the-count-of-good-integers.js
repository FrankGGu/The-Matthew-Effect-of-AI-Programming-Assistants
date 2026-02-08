var countGoodNumbers = function(n) {
    const MOD = 10**9 + 7;

    let even = Math.floor((n + 1) / 2);
    let odd = Math.floor(n / 2);

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

    return (power(5, even) * power(4, odd)) % MOD;
};