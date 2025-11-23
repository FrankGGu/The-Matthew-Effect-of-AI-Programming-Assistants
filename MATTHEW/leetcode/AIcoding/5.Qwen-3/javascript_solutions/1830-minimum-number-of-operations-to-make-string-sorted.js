function minOperationsToMakeStringSorted(s) {
    const MOD = 1000000007;
    const n = s.length;
    const fact = new Array(n + 1).fill(1);
    const invFact = new Array(n + 1).fill(1);

    for (let i = 2; i <= n; i++) {
        fact[i] = fact[i - 1] * i % MOD;
    }

    invFact[n] = pow(fact[n], MOD - 2, MOD);
    for (let i = n - 1; i >= 0; i--) {
        invFact[i] = invFact[i + 1] * (i + 1) % MOD;
    }

    const count = new Array(26).fill(0);
    for (let c of s) {
        count[c.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    let res = 0;
    for (let i = 0; i < n; i++) {
        let total = 0;
        for (let j = 0; j < 26; j++) {
            if (count[j] > 0 && String.fromCharCode(j + 'a'.charCodeAt(0)) < s[i]) {
                total = (total + count[j]) % MOD;
            }
        }

        let temp = total;
        for (let j = 0; j < 26; j++) {
            if (count[j] > 0) {
                temp = temp * invFact[count[j]] % MOD;
            }
        }

        res = (res + temp) % MOD;

        count[s[i].charCodeAt(0) - 'a'.charCodeAt(0)]--;
    }

    return res;
}

function pow(a, b, mod) {
    let result = 1;
    a = a % mod;
    while (b > 0) {
        if (b % 2 === 1) result = result * a % mod;
        a = a * a % mod;
        b = Math.floor(b / 2);
    }
    return result;
}