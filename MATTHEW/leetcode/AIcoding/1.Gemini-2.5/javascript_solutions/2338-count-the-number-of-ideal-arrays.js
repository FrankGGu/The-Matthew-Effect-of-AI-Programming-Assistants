const MOD = 10 ** 9 + 7;

const MAX_N_PLUS_LOG_MAX_VAL = 10000 + 14; // Max n (10^4) + Max log2(maxValue) (approx 13 for 10^4)
const fact = new Array(MAX_N_PLUS_LOG_MAX_VAL);
const invFact = new Array(MAX_N_PLUS_LOG_MAX_VAL);
const spf = new Array(10001); // Smallest prime factor for numbers up to maxValue (10^4)

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
    for (let i = 1; i < MAX_N_PLUS_LOG_MAX_VAL; i++) {
        fact[i] = (fact[i - 1] * i) % MOD;
    }
    invFact[MAX_N_PLUS_LOG_MAX_VAL - 1] = power(fact[MAX_N_PLUS_LOG_MAX_VAL - 1], MOD - 2);
    for (let i = MAX_N_PLUS_LOG_MAX_VAL - 2; i >= 0; i--) {
        invFact[i] = (invFact[i + 1] * (i + 1)) % MOD;
    }
}

function nCr(n_val, r_val) {
    if (r_val < 0 || r_val > n_val) return 0;
    return (((fact[n_val] * invFact[r_val]) % MOD) * invFact[n_val - r_val]) % MOD;
}

function sieve() {
    for (let i = 1; i <= 10000; i++) {
        spf[i] = i;
    }
    for (let i = 2; i * i <= 10000; i++) {
        if (spf[i] === i) { // i is prime
            for (let j = i * i; j <= 10000; j += i) {
                if (spf[j] === j) { // Only update if not already marked by a smaller prime
                    spf[j] = i;
                }
            }
        }
    }
}

let isPrecomputed = false;

var idealArrays = function(n, maxValue) {
    if (!isPrecomputed) {
        precomputeFactorials();
        sieve();
        isPrecomputed = true;
    }

    let totalWays = 0;

    for (let P = 1; P <= maxValue; P++) {
        let currentP = P;
        let waysForP = 1;

        while (currentP > 1) {
            let p_factor = spf[currentP];
            let count_e = 0;
            while (currentP % p_factor === 0) {
                count_e++;
                currentP /= p_factor;
            }
            // For each prime factor p_factor with exponent count_e,
            // we need to distribute count_e identical items into n distinct bins.
            // This is C(count_e + n - 1, n - 1).
            waysForP = (waysForP * nCr(count_e + n - 1, n - 1)) % MOD;
        }
        totalWays = (totalWays + waysForP) % MOD;
    }

    return totalWays;
};