var maxNiceDivisors = function(primeFactors) {
    const MOD = 1e9 + 7;

    if (primeFactors <= 3) return primeFactors;

    let quotient = Math.floor(primeFactors / 3);
    let remainder = primeFactors % 3;

    if (remainder === 0) {
        return powMod(3, quotient, MOD);
    } else if (remainder === 1) {
        return (powMod(3, quotient - 1, MOD) * 4) % MOD;
    } else {
        return (powMod(3, quotient, MOD) * 2) % MOD;
    }
};

function powMod(base, exponent, mod) {
    let result = 1;
    while (exponent > 0) {
        if (exponent % 2 === 1) {
            result = (result * base) % mod;
        }
        base = (base * base) % mod;
        exponent = Math.floor(exponent / 2);
    }
    return result;
}