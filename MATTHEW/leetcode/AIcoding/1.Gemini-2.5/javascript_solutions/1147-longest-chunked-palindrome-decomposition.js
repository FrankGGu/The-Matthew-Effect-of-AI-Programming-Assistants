let memo;
let text_global;
let powers;
let forward_hashes;
const P = 31;
const M = 1_000_000_007;

function init_hashes(s) {
    const N = s.length;
    text_global = s;

    powers = new Array(N + 1);
    forward_hashes = new Array(N + 1).fill(0);

    powers[0] = 1;
    for (let i = 1; i <= N; i++) {
        powers[i] = (powers[i - 1] * P) % M;
    }

    for (let i = 0; i < N; i++) {
        forward_hashes[i + 1] = (forward_hashes[i] * P + (s.charCodeAt(i) - 96)) % M;
    }
}

function get_hash(start, end) {
    if (start > end) return 0;
    const len = end - start + 1;
    let hash_val = (forward_hashes[end + 1] - (forward_hashes[start] * powers[len]) % M + M) % M;
    return hash_val;
}

function solve(start, end) {
    if (start > end) return 0;
    if (start === end) return 1;

    const key = start + "," + end;
    if (memo.has(key)) {
        return memo.get(key);
    }

    const current_len = end - start + 1;

    for (let i = 1; i <= current_len / 2; i++) {
        const prefix_hash = get_hash(start, start + i - 1);
        const suffix_hash = get_hash(end - i + 1, end);

        if (prefix_hash === suffix_hash) {
            const result = 2 + solve(start + i, end - i);
            memo.set(key, result);
            return result;
        }
    }

    const result = 1;
    memo.set(key, result);
    return result;
}

var longestDecomposition = function(text) {
    memo = new Map();
    init_hashes(text);

    return solve(0, text.length - 1);
};