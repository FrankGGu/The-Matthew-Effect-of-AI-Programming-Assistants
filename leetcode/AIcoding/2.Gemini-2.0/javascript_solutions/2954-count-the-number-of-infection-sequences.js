var countTheNumberOfInfectionSequences = function(n, m) {
    const MOD = 1000000007;

    function power(base, exp) {
        let res = 1;
        base %= MOD;
        while (exp > 0) {
            if (exp % 2 === 1) res = (res * base) % MOD;
            base = (base * base) % MOD;
            exp = Math.floor(exp / 2);
        }
        return res;
    }

    function modInverse(n) {
        return power(n, MOD - 2);
    }

    function factorial(n) {
        let res = 1;
        for (let i = 2; i <= n; i++)
            res = (res * i) % MOD;
        return res;
    }

    function nCr(n, r) {
        if (r < 0 || r > n) return 0;
        let num = factorial(n);
        let den = (factorial(r) * factorial(n - r)) % MOD;
        return (num * modInverse(den)) % MOD;
    }

    if (m > n) return 0;

    let combinations = nCr(n, m);
    let arrangements = factorial(m);
    let nonInfectedArrangements = power(2, m - 1);

    return (((combinations * arrangements) % MOD) * nonInfectedArrangements) % MOD;
};