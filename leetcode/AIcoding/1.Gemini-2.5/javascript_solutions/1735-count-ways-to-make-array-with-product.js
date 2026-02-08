const MOD = 1000000007;
const MAX_EXPONENT_SUM = 9000; // Max exponent for a prime (e.g., 2 in 1000^1000)

const fact = new Array(MAX_EXPONENT_SUM + 1);
const invFact = new Array(MAX_EXPONENT_SUM + 1);

const primes = [];

function sieve() {
    const isPrime = new Array(1001).fill(true);
    isPrime[0] = isPrime[1] = false;
    for (let p = 2; p <= 1000; p++) {
        if (isPrime[p]) {
            primes.push(p);
            for (let multiple = p * p; multiple <= 1000; multiple += p) {
                isPrime[multiple] = false;
            }
        }
    }
}
sieve();

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

function precomputeFactorialsOptimized() {
    fact[0] = 1;
    for (let i = 1; i <= MAX_EXPONENT_SUM; i++) {
        fact[i] = (fact[i - 1] * i) % MOD;
    }
    invFact[MAX_EXPONENT_SUM] = modInverse(fact[MAX_EXPONENT_SUM]);
    for (let i = MAX_EXPONENT_SUM - 1; i >= 0; i--) {
        invFact[i] = (invFact[i + 1] * (i + 1)) % MOD;
    }
}
precomputeFactorialsOptimized();

let K_PARAM_MINUS_1_MOD;

function nCk_largeN_smallK(N_val, K_val) {
    if (K_val < 0 || K_val > N_val) return 0;
    if (K_val === 0 || K_val === N_val) return 1;
    if (K_val > N_val / 2) K_val = N_val - K_val;

    let res = 1;
    for (let i = 0; i < K_val; i++) {
        // N_val - i = (exponent + k - 1) - i = (exponent - i) + (k - 1)
        // (exponent - i) is K_val - i.
        // We need ((K_val - i) + (k - 1)) % MOD
        let term = (K_PARAM_MINUS_1_MOD + K_val - i) % MOD;
        if (term < 0) term += MOD;
        res = (res * term) % MOD;
    }
    res = (res * invFact[K_val]) % MOD;
    return res;
}

function getPrimeFactorizationMap(n) {
    const factors = new Map();
    let tempN = n;
    for (let i = 0; i < primes.length; i++) {
        const p = primes[i];
        if (p * p > tempN) break;
        if (tempN % p === 0) {
            let count = 0;
            while (tempN % p === 0) {
                count++;
                tempN = Math.floor(tempN / p);
            }
            factors.set(i, count);
        }
    }
    if (tempN > 1) {
        let low = 0, high = primes.length - 1;
        let primeIndex = -1;
        while(low <= high) {
            let mid = Math.floor((low + high) / 2);
            if (primes[mid] === tempN) {
                primeIndex = mid;
                break;
            } else if (primes[mid] < tempN) {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        factors.set(primeIndex, (factors.get(primeIndex) || 0) + 1);
    }
    return factors;
}

function serializeFactorsMap(factorsMap) {
    const parts = [];
    const sortedKeys = Array.from(factorsMap.keys()).sort((a, b) => a - b);
    for (const key of sortedKeys) {
        parts.push(`${key}:${factorsMap.get(key)}`);
    }
    return parts.join(',');
}

function parseFactorsStr(str) {
    const factorsMap = new Map();
    if (str === "") return factorsMap;
    const parts = str.split(',');
    for (const part of parts) {
        const [key, value] = part.split(':').map(Number);
        factorsMap.set(key, value);
    }
    return factorsMap;
}

function countWaysToMakeArrayWithProduct(nums, k) {
    K_PARAM_MINUS_1_MOD = (k - 1) % MOD;

    let dp = new Map();
    dp.set("", 1); // Represents product 1. f(1) = 1.

    for (const num of nums) {
        if (num === 1) {
            continue;
        }

        const num_factors = getPrimeFactorizationMap(num);
        const products_from_num = new Map();

        for (const [prev_factors_str, prev_f_val] of dp.entries()) {
            const prev_factors_map = parseFactorsStr(prev_factors_str);
            const current_factors_map = new Map(prev_factors_map);
            let current_f_val = prev_f_val;

            for (const [p_idx, e] of num_factors.entries()) {
                const prev_exp_p = current_factors_map.get(p_idx) || 0;
                const new_exp_p = prev_exp_p + e;

                if (prev_exp_p > 0) {
                    current_f_val = (current_f_val * modInverse(nCk_largeN_smallK(prev_exp_p + k - 1, prev_exp_p))) % MOD;
                }
                current_f_val = (current_f_val * nCk_largeN_smallK(new_exp_p + k - 1, new_exp_p)) % MOD;
                current_factors_map.set(p_idx, new_exp_p);
            }

            const current_factors_str = serializeFactorsMap(current_factors_map);
            products_from_num.set(current_factors_str, current_f_val);
        }

        for (const [key, value] of products_from_num.entries()) {
            dp.set(key, value);
        }
    }

    let total_ways = 0;
    for (const f_val of dp.values()) {
        total_ways = (total_ways + f_val) % MOD;
    }

    return total_ways;
}