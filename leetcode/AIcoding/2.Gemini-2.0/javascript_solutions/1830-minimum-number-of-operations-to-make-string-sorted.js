var makeStringSorted = function(s) {
    const MOD = 10**9 + 7;
    const n = s.length;
    const counts = new Array(26).fill(0);
    for (const char of s) {
        counts[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    let ans = 0;
    let fact = [1];
    for (let i = 1; i <= n; i++) {
        fact[i] = (fact[i - 1] * i) % MOD;
    }

    function modInverse(a, m) {
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
    }

    for (let i = 0; i < n; i++) {
        let smaller = 0;
        for (let j = 0; j < s.charCodeAt(i) - 'a'.charCodeAt(0); j++) {
            smaller += counts[j];
        }

        let numerator = fact[n - i - 1];
        let denominator = 1;
        for (let j = 0; j < 26; j++) {
            denominator = (denominator * fact[counts[j]]) % MOD;
        }

        let invDenominator = modInverse(denominator, MOD);
        ans = (ans + (smaller * numerator % MOD) * invDenominator % MOD) % MOD;

        counts[s.charCodeAt(i) - 'a'.charCodeAt(0)]--;
    }

    return ans;
};