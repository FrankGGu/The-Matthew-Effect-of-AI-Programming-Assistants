const MOD = 10**9 + 7;
const MAX_N = 100000;

let fact = new Array(MAX_N + 1);
let invFact = new Array(MAX_N + 1);
let precomputed = false;

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

function precomputeFactorials() {
    fact[0] = 1;
    invFact[0] = 1;
    for (let i = 1; i <= MAX_N; i++) {
        fact[i] = (fact[i-1] * i) % MOD;
    }
    invFact[MAX_N] = power(fact[MAX_N], MOD - 2);
    for (let i = MAX_N - 1; i >= 1; i--) {
        invFact[i] = (invFact[i + 1] * (i + 1)) % MOD;
    }
}

var makeStringSorted = function(s) {
    if (!precomputed) {
        precomputeFactorials();
        precomputed = true;
    }

    const n = s.length;
    let freq = new Array(26).fill(0);
    for (let i = 0; i < n; i++) {
        freq[s.charCodeAt(i) - 97]++;
    }

    let ans = 0;
    for (let i = 0; i < n; i++) {
        const char_val = s.charCodeAt(i) - 97;

        let num_smaller_chars = 0;
        for (let j = 0; j < char_val; j++) {
            num_smaller_chars = (num_smaller_chars + freq[j]) % MOD;
        }

        let current_denominator_inv = 1;
        for (let j = 0; j < 26; j++) {
            current_denominator_inv = (current_denominator_inv * invFact[freq[j]]) % MOD;
        }

        let term = (num_smaller_chars * fact[n - 1 - i]) % MOD;
        term = (term * current_denominator_inv) % MOD;
        ans = (ans + term) % MOD;

        freq[char_val]--;
    }

    return ans;
};