const MOD = 1e9 + 7;

function makeStringSorted(s) {
    const n = s.length;
    const fact = new Array(n + 1).fill(1);
    const invFact = new Array(n + 1).fill(1);

    for (let i = 1; i <= n; i++) {
        fact[i] = (fact[i - 1] * i) % MOD;
    }

    invFact[n] = modInverse(fact[n], MOD);
    for (let i = n - 1; i >= 0; i--) {
        invFact[i] = (invFact[i + 1] * (i + 1)) % MOD;
    }

    let res = 0;
    const freq = new Array(26).fill(0);

    for (let i = n - 1; i >= 0; i--) {
        const c = s.charCodeAt(i) - 'a'.charCodeAt(0);
        freq[c]++;
        let sum = 0;
        for (let j = 0; j < c; j++) {
            sum += freq[j];
        }
        let denominator = 1;
        for (let j = 0; j < 26; j++) {
            denominator = (denominator * invFact[freq[j]]) % MOD;
        }
        const term = (sum * fact[n - i - 1]) % MOD;
        const total = (term * denominator) % MOD;
        res = (res + total) % MOD;
    }

    return res;
}

function modInverse(a, mod) {
    let [oldR, r] = [a, mod];
    let [oldS, s] = [1, 0];

    while (r !== 0) {
        const quotient = Math.floor(oldR / r);
        [oldR, r] = [r, oldR - quotient * r];
        [oldS, s] = [s, oldS - quotient * s];
    }

    return oldS < 0 ? oldS + mod : oldS;
}