var countBalancedPermutations = function(n) {
    const MOD = 10**9 + 7;
    const fact = new Array(n + 1).fill(0);
    fact[0] = 1;
    for (let i = 1; i <= n; i++) {
        fact[i] = (fact[i - 1] * i) % MOD;
    }

    const modInverse = (a, m) => {
        let m0 = m;
        let y = 0, x = 1;

        if (m == 1)
            return 0;

        while (a > 1) {
            let q = Math.floor(a / m);
            let t = m;
            m = a % m, a = t;
            t = y;
            y = x - q * y;
            x = t;
        }

        if (x < 0)
            x += m0;

        return x;
    };

    const binomialCoefficient = (n, k) => {
        if (k < 0 || k > n) {
            return 0;
        }
        if (k === 0 || k === n) {
            return 1;
        }
        if (k > n / 2) {
            k = n - k;
        }

        let numerator = fact[n];
        let denominator = (fact[k] * fact[n - k]) % MOD;

        return (numerator * modInverse(denominator, MOD)) % MOD;
    };

    if (n % 2 !== 0) return 0;

    let half = n / 2;

    let res = (fact[half] * fact[half]) % MOD;

    res = (res * binomialCoefficient(n, half)) % MOD;

    res = (res * modInverse(fact[half],MOD)) % MOD;

    return res;
};