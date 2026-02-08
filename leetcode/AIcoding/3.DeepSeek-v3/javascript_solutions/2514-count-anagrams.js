const MOD = 1e9 + 7;

function countAnagrams(s) {
    const words = s.split(' ');
    let result = 1;

    for (const word of words) {
        const freq = {};
        for (const c of word) {
            freq[c] = (freq[c] || 0) + 1;
        }
        let denominator = 1;
        for (const key in freq) {
            denominator = (denominator * factorial(freq[key])) % MOD;
        }
        const numerator = factorial(word.length);
        const value = (numerator * modInverse(denominator, MOD)) % MOD;
        result = (result * value) % MOD;
    }

    return result;
}

function factorial(n) {
    let res = 1;
    for (let i = 2; i <= n; i++) {
        res = (res * i) % MOD;
    }
    return res;
}

function modInverse(a, mod) {
    return power(a, mod - 2, mod);
}

function power(a, b, mod) {
    let result = 1;
    a = a % mod;
    while (b > 0) {
        if (b % 2 === 1) {
            result = (result * a) % mod;
        }
        a = (a * a) % mod;
        b = Math.floor(b / 2);
    }
    return result;
}