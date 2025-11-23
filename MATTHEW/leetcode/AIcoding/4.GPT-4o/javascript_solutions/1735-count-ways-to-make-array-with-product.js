var countWays = function (nums) {
    const MOD = 1e9 + 7;
    let count = 1;
    const primeFactors = {};

    for (const num of nums) {
        const factors = getPrimeFactors(num);
        for (const [prime, exp] of Object.entries(factors)) {
            if (!primeFactors[prime]) {
                primeFactors[prime] = 0;
            }
            primeFactors[prime] += exp;
        }
    }

    for (const exp of Object.values(primeFactors)) {
        count = (count * (exp + 1)) % MOD;
    }

    return count;
};

function getPrimeFactors(n) {
    const factors = {};
    for (let i = 2; i * i <= n; i++) {
        while (n % i === 0) {
            factors[i] = (factors[i] || 0) + 1;
            n /= i;
        }
    }
    if (n > 1) {
        factors[n] = (factors[n] || 0) + 1;
    }
    return factors;
}