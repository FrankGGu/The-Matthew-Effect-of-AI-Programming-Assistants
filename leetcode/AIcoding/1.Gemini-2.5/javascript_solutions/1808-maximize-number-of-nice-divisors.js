var maxNiceDivisors = function(primeFactors) {
    const MOD = 10**9 + 7;

    const power = (base, exp) => {
        let res = 1;
        base %= MOD;
        while (exp > 0) {
            if (exp % 2 === 1) {
                res = (res * base) % MOD;
            }
            base = (base * base) % MOD;
            exp = Math.floor(exp / 2);
        }
        return res;
    };

    if (primeFactors <= 3) {
        return primeFactors;
    }

    if (primeFactors % 3 === 0) {
        return power(3, primeFactors / 3);
    } else if (primeFactors % 3 === 1) {
        // For n = 3k + 1, it's optimal to use (k-1) threes and one four (2*2).
        // Example: n=4 -> 4. n=7 -> 3*4=12.
        return (power(3, (primeFactors - 4) / 3) * 4) % MOD;
    } else { // primeFactors % 3 === 2
        // For n = 3k + 2, it's optimal to use k threes and one two.
        // Example: n=5 -> 3*2=6.
        return (power(3, Math.floor(primeFactors / 3)) * 2) % MOD;
    }
};