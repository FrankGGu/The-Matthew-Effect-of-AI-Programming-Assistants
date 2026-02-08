var stringCount = function(n) {
    const MOD = 1e9 + 7;
    let total = 0;

    // Total possible strings: 26^n
    total = powMod(26, n, MOD);

    // Subtract strings missing 'l' or 't' or 'e' or at least two 'e's
    // Using inclusion-exclusion principle

    // Strings missing 'l': 25^n
    let missingL = powMod(25, n, MOD);

    // Strings missing 't': 25^n
    let missingT = powMod(25, n, MOD);

    // Strings missing 'e': 25^n
    let missingE = powMod(25, n, MOD);

    // Strings missing both 'l' and 't': 24^n
    let missingLT = powMod(24, n, MOD);

    // Strings missing both 'l' and 'e': 24^n
    let missingLE = powMod(24, n, MOD);

    // Strings missing both 't' and 'e': 24^n
    let missingTE = powMod(24, n, MOD);

    // Strings missing all 'l', 't', 'e': 23^n
    let missingLTE = powMod(23, n, MOD);

    // Strings with at most one 'e': (25^n + n * 25^(n-1))
    let atMostOneE = (powMod(25, n, MOD) + n * powMod(25, n - 1, MOD)) % MOD;

    // Apply inclusion-exclusion
    let bad = (missingL + missingT + missingE - missingLT - missingLE - missingTE + missingLTE) % MOD;
    bad = (bad + atMostOneE - missingE) % MOD;

    let res = (total - bad) % MOD;
    return res < 0 ? res + MOD : res;
};

function powMod(a, b, mod) {
    let res = 1;
    a = a % mod;
    while (b > 0) {
        if (b % 2 === 1) {
            res = (res * a) % mod;
        }
        a = (a * a) % mod;
        b = Math.floor(b / 2);
    }
    return res;
}