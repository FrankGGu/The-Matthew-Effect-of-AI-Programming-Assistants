var waysToFillArray = function(queries, n) {
    const MOD = 10**9 + 7;

    function primeFactorization(num) {
        const factors = {};
        for (let i = 2; i * i <= num; i++) {
            while (num % i === 0) {
                factors[i] = (factors[i] || 0) + 1;
                num /= i;
            }
        }
        if (num > 1) {
            factors[num] = (factors[num] || 0) + 1;
        }
        return factors;
    }

    function combinations(n, k) {
        if (k < 0 || k > n) return 0;
        if (k === 0 || k === n) return 1;
        if (k > n / 2) k = n - k;

        let res = 1;
        for (let i = 1; i <= k; i++) {
            res = (res * (n - i + 1)) / i;
        }
        return Math.round(res);
    }

    const maxVal = Math.max(...queries.map(q => q[1]));
    const primeFactorsCache = {};
    for (let i = 1; i <= maxVal; i++) {
        primeFactorsCache[i] = primeFactorization(i);
    }

    const results = [];
    for (const [length, product] of queries) {
        let totalWays = 1;
        const factors = primeFactorsCache[product];
        for (const prime in factors) {
            const count = factors[prime];
            totalWays = (totalWays * combinations(length + count - 1, count)) % MOD;
        }
        results.push(totalWays);
    }

    return results;
};