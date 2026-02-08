var valueAfterKSeconds = function(n, k) {
    const MOD = 10**9 + 7;

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

    const maxVal = n - 1 + k;
    const fact = new Array(maxVal + 1);
    fact[0] = 1;
    for (let i = 1; i <= maxVal; i++) {
        fact[i] = (fact[i - 1] * i) % MOD;
    }

    const N_val = n - 1 + k;
    const K_val = k;

    const numerator = fact[N_val];
    const denominator = (fact[K_val] * fact[N_val - K_val]) % MOD;

    const result = (numerator * modInverse(denominator)) % MOD;

    return result;
};