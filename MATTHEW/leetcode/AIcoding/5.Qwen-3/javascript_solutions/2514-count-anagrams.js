function countAnagrams(s) {
    const MOD = 10 ** 9 + 7;
    const factorial = new Array(s.length + 1).fill(1);
    for (let i = 2; i <= s.length; i++) {
        factorial[i] = (factorial[i - 1] * i) % MOD;
    }
    const freq = new Array(26).fill(0);
    for (const c of s) {
        freq[c.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }
    let result = factorial[s.length];
    for (let i = 0; i < 26; i++) {
        if (freq[i] > 0) {
            result = (result * pow(freq[i], MOD - 2, MOD)) % MOD;
        }
    }
    return result;
}

function pow(a, b, mod) {
    let result = 1;
    a = a % mod;
    while (b > 0) {
        if (b % 2 === 1) result = (result * a) % mod;
        a = (a * a) % mod;
        b = Math.floor(b / 2);
    }
    return result;
}