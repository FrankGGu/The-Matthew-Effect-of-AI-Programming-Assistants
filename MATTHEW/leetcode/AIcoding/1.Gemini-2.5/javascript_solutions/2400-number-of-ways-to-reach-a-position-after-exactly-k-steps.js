const MOD = 10**9 + 7;
const MAX_K = 1000; 
const fact = new Array(MAX_K + 1);
const invFact = new Array(MAX_K + 1);

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

(function() {
    fact[0] = 1;
    for (let i = 1; i <= MAX_K; i++) {
        fact[i] = (fact[i - 1] * i) % MOD;
    }

    invFact[MAX_K] = modInverse(fact[MAX_K]);
    for (let i = MAX_K - 1; i >= 0; i--) {
        invFact[i] = (invFact[i + 1] * (i + 1)) % MOD;
    }
})();

function nCr_mod_p(n, r) {
    if (r < 0 || r > n) return 0;
    return (((fact[n] * invFact[r]) % MOD) * invFact[n - r]) % MOD;
}

var numberOfWays = function(startPos, endPos, k) {
    const diff = endPos - startPos;

    if ((diff + k) % 2 !== 0) {
        return 0;
    }

    if (Math.abs(diff) > k) {
        return 0;
    }

    const r = (diff + k) / 2;

    return nCr_mod_p(k, r);
};