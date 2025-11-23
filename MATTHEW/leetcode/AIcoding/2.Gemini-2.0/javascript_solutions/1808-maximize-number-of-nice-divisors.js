var maxNiceDivisors = function(primeFactors) {
    const MOD = 1000000007;

    if (primeFactors <= 3) {
        return primeFactors;
    }

    if (primeFactors % 3 === 0) {
        return power(3, primeFactors / 3, MOD);
    } else if (primeFactors % 3 === 1) {
        return (power(3, (primeFactors - 4) / 3, MOD) * 4) % MOD;
    } else {
        return (power(3, (primeFactors - 2) / 3, MOD) * 2) % MOD;
    }

    function power(base, exp, mod) {
        let res = 1;
        base %= mod;
        while (exp > 0) {
            if (exp % 2 === 1) res = (res * base) % mod;
            base = (base * base) % mod;
            exp = Math.floor(exp / 2);
        }
        return res;
    }
};