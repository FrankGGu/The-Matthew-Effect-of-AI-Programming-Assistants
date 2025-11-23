var countGoodNumbers = function(n) {
    const MOD = 10**9 + 7;

    let odd = Math.floor(n / 2);
    let even = n - odd;

    let pow5 = (base, exp, mod) => {
        let res = 1;
        base %= mod;
        while (exp > 0) {
            if (exp % 2 === 1) res = (res * base) % mod;
            base = (base * base) % mod;
            exp = Math.floor(exp / 2);
        }
        return res;
    };

    let pow4 = (base, exp, mod) => {
        let res = 1;
        base %= mod;
        while (exp > 0) {
            if (exp % 2 === 1) res = (res * base) % mod;
            base = (base * base) % mod;
            exp = Math.floor(exp / 2);
        }
        return res;
    };

    return (pow5(5, even, MOD) * pow4(4, odd, MOD)) % MOD;
};