const BASE1 = 31;
const MOD1 = 1e9 + 7;
const BASE2 = 37;
const MOD2 = 1e9 + 9;

let pow1 = [];
let pow2 = [];

function precomputePowers(nMax) {
    pow1 = new Array(nMax + 1);
    pow2 = new Array(nMax + 1);
    pow1[0] = 1;
    pow2[0] = 1;
    for (let i = 1; i <= nMax; i++) {
        pow1[i] = (pow1[i - 1] * BASE1) % MOD1;
        pow2[i] = (pow2[i - 1] * BASE2) % MOD2;
    }
}

var minimumEffort = function(target, words) {
    if (pow1.length === 0) {
        precomputePowers(1000); // Max length for target or word is 1000
    }

    const n = target.length;

    const h1_target_prefix = new Array(n + 1).fill(0);
    const h2_target_prefix = new Array(n + 1).fill(0);

    for (let i = 0; i < n; i++) {
        const charVal = target.charCodeAt(i) - 'a'.charCodeAt(0) + 1;
        h1_target_prefix[i + 1] = (h1_target_prefix[i] * BASE1 + charVal) % MOD1;
        h2_target_prefix[i + 1] = (h2_target_prefix[i] * BASE2 + charVal) % MOD2;
    }

    const getTargetSubstringHash = (start, end) => {
        const len = end - start;
        const hash1 = (h1_target_prefix[end] - (h1_target_prefix[start] * pow1[len]) % MOD1 + MOD1) % MOD1;
        const hash2 = (h2_target_prefix[end] - (h2_target_prefix[start] * pow2[len]) % MOD2 + MOD2) % MOD2;
        return `${hash1},${hash2}`;
    };

    const validWordHashes = new Set();

    for (const w of words) {
        const len_w = w.length;

        const h1_w_prefix = new Array(len_w + 1).fill(0);
        const h2_w_prefix = new Array(len_w + 1).fill(0);
        for (let k = 0; k < len_w; k++) {
            const charVal = w.charCodeAt(k) - 'a'.charCodeAt(0) + 1;
            h1_w_prefix[k + 1] = (h1_w_prefix[k] * BASE1 + charVal) % MOD1;
            h2_w_prefix[k + 1] = (h2_w_prefix[k] * BASE2 + charVal) % MOD2;
        }

        const getWSubstringHash = (start, end) => {
            const sub_len = end - start;
            const hash1 = (h1_w_prefix[end] - (h1_w_prefix[start] * pow1[sub_len]) % MOD1 + MOD1) % MOD1;
            const hash2 = (h2_w_prefix[end] - (h2_w_prefix[start] * pow2[sub_len]) % MOD2 + MOD2) % MOD2;
            return `${hash1},${hash2}`;
        };

        let foundValid = false;
        for (let x = 0; x <= Math.min(n, len_w); x++) {
            const prefix_len_w = x;
            const suffix_len_w = len_w - prefix_len_w;

            if (suffix_len_w < 0 || suffix_len_w > n) {
                continue;
            }

            const y = n - suffix_len_w;
            if (y < x) {
                continue;
            }

            let isMatch = false;
            if (prefix_len_w === 0) {
                const hash_w_full = getWSubstringHash(0, len_w);
                const hash_target_s = getTargetSubstringHash(y, n);
                if (hash_w_full === hash_target_s) {
                    isMatch = true;
                }
            } else if (suffix_len_w === 0) {
                const hash_w_full = getWSubstringHash(0, len_w);
                const hash_target_p = getTargetSubstringHash(0, prefix_len_w);
                if (hash_w_full === hash_target_p) {
                    isMatch = true;
                }
            } else {
                const hash_w_p = getWSubstringHash(0, prefix_len_w);
                const hash_target_p = getTargetSubstringHash(0, prefix_len_w);

                if (hash_w_p !== hash_target_p) {
                    continue;
                }

                const hash_w_s = getWSubstringHash(prefix_len_w, len_w);
                const hash_target_s = getTargetSubstringHash(y, n);

                if (hash_w_s === hash_target_s) {
                    isMatch = true;
                }
            }

            if (isMatch) {
                validWordHashes.add(getWSubstringHash(0, len_w));
                foundValid = true;
                break;
            }
        }
    }

    const dp = new Array(n + 1).fill(Infinity);
    dp[0] = 0;

    for (let i = 1; i <= n; i++) {
        for (let j = 0; j < i; j++) {
            if (dp[j] === Infinity) {
                continue;
            }
            const subHash = getTargetSubstringHash(j, i);
            if (validWordHashes.has(subHash)) {
                dp[i] = Math.min(dp[i], dp[j] + 1);
            }
        }
    }

    return dp[n] === Infinity ? -1 : dp[n];
};