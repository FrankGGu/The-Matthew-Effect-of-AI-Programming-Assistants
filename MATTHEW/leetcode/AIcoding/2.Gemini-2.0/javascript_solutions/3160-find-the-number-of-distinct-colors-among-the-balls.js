var distinctColors = function(balls) {
    const MOD = 10**9 + 7;
    let n = balls.reduce((a, b) => a + b, 0);
    let k = balls.length;

    let fact = new Array(n + 1).fill(0);
    fact[0] = 1;
    for (let i = 1; i <= n; i++) {
        fact[i] = (fact[i - 1] * i) % MOD;
    }

    function power(base, exp) {
        let res = 1;
        base %= MOD;
        while (exp > 0) {
            if (exp % 2 == 1) res = (res * base) % MOD;
            base = (base * base) % MOD;
            exp = Math.floor(exp / 2);
        }
        return res;
    }

    function modInverse(n) {
        return power(n, MOD - 2);
    }

    let numerator = fact[n];
    let denominator = 1;
    for (let i = 0; i < k; i++) {
        denominator = (denominator * fact[balls[i]]) % MOD;
    }

    return (numerator * modInverse(denominator)) % MOD;
};